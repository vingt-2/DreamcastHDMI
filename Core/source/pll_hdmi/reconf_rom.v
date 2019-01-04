module reconf_rom (
    input clock,
    input [7:0] address,
    input read_ena,
    output q,
    output reconfig,

    input rdempty,
    input [7:0] fdata,
    output reg rdreq,
    output reg trigger_read,
    output reg forceVGAMode,
    output DCVideoConfig dcVideoConfig
);

reg _read_ena = 0;
reg q_reg;
reg q_reg_2;
reg doReconfig;
reg doReconfig_2;
reg doReconfig_3;

reg [7:0] fdata_req;

assign q = q_reg_2;
assign reconfig = doReconfig_3;

`include "../config/dc_config.v"

initial begin
    dcVideoConfig <= DC_VIDEO_CONFIG_1080P;
end

always @(posedge clock) begin
    _read_ena <= read_ena;

    if (_read_ena && ~read_ena) begin
        doReconfig <= 1;
    end else begin
        doReconfig <= 0;
    end

    if (~rdempty) begin
        rdreq <= 1'b1;
    end else begin
        rdreq <= 1'b0;
    end

    if (rdreq) begin
        fdata_req <= fdata;
        trigger_read <= 1'b1;
        forceVGAMode <= fdata[7];
        case (fdata[3:0])
            4'h0: begin
                dcVideoConfig <= DC_VIDEO_CONFIG_1080P;
            end
            4'h1: begin
                dcVideoConfig <= DC_VIDEO_CONFIG_960P;
            end
            4'h2: begin
                dcVideoConfig <= DC_VIDEO_CONFIG_480P;
            end
            4'h3: begin
                dcVideoConfig <= DC_VIDEO_CONFIG_VGA;
            end
            4'h8: begin
                dcVideoConfig <= DC_VIDEO_CONFIG_240P_1080P;
            end
            4'h9: begin
                dcVideoConfig <= DC_VIDEO_CONFIG_240P_960P;
            end
            4'hA: begin
                dcVideoConfig <= DC_VIDEO_CONFIG_240P_480P;
            end
            4'hB: begin
                dcVideoConfig <= DC_VIDEO_CONFIG_240P_VGA;
            end
        endcase
    end else begin
        trigger_read <= 1'b0;
    end

    case (fdata_req[3:0])
        4'h0: begin
            `include "config/1080p.v"
        end
        4'h1: begin
            `include "config/960p.v"
        end
        4'h2: begin
            `include "config/480p.v"
        end
        4'h3: begin
            `include "config/VGA.v"
        end
        4'h8: begin
            `include "config/240p_1080p.v"
        end
        4'h9: begin
            `include "config/960p.v"
        end
        4'hA: begin
            `include "config/480p.v"
        end
        4'hB: begin
            `include "config/VGA.v"
        end
    endcase

    // delay output, to match ROM based timing
    q_reg_2 <= q_reg;
    doReconfig_2 <= doReconfig;
    doReconfig_3 <= doReconfig_2;
end

endmodule
