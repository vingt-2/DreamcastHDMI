// DEBUG Information
typedef struct packed {
    reg [7:0] pll_errors;
    reg [7:0] test;

    reg [9:0] frame_counter;
    reg [7:0] pll_status;
    reg [7:0] id_check_high;
    reg [7:0] id_check_low;
    reg [7:0] chip_revision;
    reg [7:0] vic_detected;
    reg [7:0] vic_to_rx;
    reg [7:0] misc_data;

    reg [7:0] cts1_status;
    reg [7:0] cts2_status;
    reg [7:0] cts3_status;

    reg [7:0] max_cts1_status;
    reg [7:0] max_cts2_status;
    reg [7:0] max_cts3_status;

    reg [7:0] summary_cts1_status;
    reg [7:0] summary_cts2_status;
    reg [7:0] summary_cts3_status;
    reg [7:0] summary_summary_cts3_status;

    reg [7:0] restart_count;
    reg [7:0] hdmi_int_count;
    reg [7:0] hdmi_int_processed_count;
    reg [7:0] not_ready_count;

    reg [7:0] resync_count;
} DebugData;

// Maple Controller Data
typedef struct packed {
    reg a;           // 12
    reg b;           // 11
    reg x;           // 10
    reg y;           // 09

    reg up;          // 08
    reg down;        // 07
    reg left;        // 06
    reg right;       // 05

    reg start;       // 04
    reg ltrigger;    // 03
    reg rtrigger;    // 02

    // meta
    reg trigger_osd; // 01
    reg trigger_default_resolution; // 00

} ControllerData;

typedef struct packed {
    // output video definition
    reg [11:0] horizontal_pixels_per_line;  // 12'd1100 for 1080p
    reg [11:0] horizontal_pixels_visible;   // 12'd960 for 1080p
    reg [11:0] horizontal_sync_start;       // 12'd1004 for 1080p
    reg [11:0] horizontal_sync_width;       // 12'd22 for 1080p
    reg horizontal_sync_on_polarity;        // 1'b1 for 1080p

    reg [10:0] vertical_lines;              // 11'd1125 for 1080p
    reg [10:0] vertical_lines_240p;         // 11'd1125 for 1080p
    reg [10:0] vertical_lines_visible;      // 11'd1080 for 1080p
    reg [10:0] vertical_sync_start;         // 11'd1084 for 1080p
    reg [10:0] vertical_sync_width;         // 11'd5 for 1080p
    reg vertical_sync_on_polarity;          // 1'b1 for 1080p

    reg [9:0] horizontal_offset;            // 10'd160 for 1080p
    reg [9:0] vertical_offset;              // 10'd60 for 1080p

    reg [11:0] horizontal_capture_start;    //
    reg [11:0] horizontal_capture_end;      //

    reg [10:0] vertical_capture_start;      //
    reg [10:0] vertical_capture_end;        //

    // OSD related settings
    reg [11:0] osd_bg_offset_x_start;       // start of osd area
    reg [11:0] osd_bg_offset_x_end;         // visible_pixels
    reg [10:0] osd_bg_offset_y_start;       // 
    reg [10:0] osd_bg_offset_y_end;         // 

    reg [11:0] osd_text_x_start;            // start of osd area
    reg [11:0] osd_text_x_end;              // visible_pixels
    reg [10:0] osd_text_y_start;            // 
    reg [10:0] osd_text_y_end;              // 

    reg [11:0] text_offset_character_x;     // (text_offset_counter_x + horizontal_offset) / 8
    reg [10:0] text_offset_character_y;     // (text_offset_counter_y + vertical_offset) / (pixel_repetition ? 32 : 16)

    reg [14:0] buffer_line_length;          // 720 for 480p, 640 for others
    reg [14:0] ram_numwords;                // size of video buffer, 21120 for 1080p
    reg pixel_repetition;                   // 0: pixel repetition OFF, 1: pixel repetition ON

    reg pxl_rep_on;                         // activate extended pixel repetition mode
    reg [3:0] pxl_rep_h;                    // horizontal repetition rate
    reg [3:0] pxl_rep_v;                    // vertical repetition rate
    reg [1:0] pxl_rep_addr_inr_h;           // horizontal pixel increment

    reg [31:0] startup_delay;               // pixel_clk * 200ms / 1000ms
} HDMIVideoConfig;

typedef struct packed {
    reg [3:0] ICS644_settings_p;
    reg [3:0] ICS644_settings_i;

    reg [9:0] p_horizontal_capture_start;
    reg [9:0] p_horizontal_capture_end;
    reg [9:0] p_vertical_capture_start;
    reg [9:0] p_vertical_capture_end;

    reg [9:0] i_horizontal_capture_start;
    reg [9:0] i_horizontal_capture_end;
    reg [9:0] i_vertical_capture_start;
    reg [9:0] i_vertical_capture_end;

    reg [7:0] buffer_size;         // lines of video buffer
    reg [14:0] ram_numwords;       // size of video buffer, 21120 for 1080p
    reg [14:0] trigger_address_p;  // ram address where to trigger output start (VGA mode)
    reg [14:0] trigger_address_i;  // ram address where to trigger output start (15kHz mode)
    reg [14:0] buffer_line_length; // 720 for 480p, 640 for others
} DCVideoConfig;

typedef struct packed {
    reg[8:0] intensity; // 03-10 256=100% brightness, 0=complete black
    reg thickness;      // 02: 1 thick, 0 thin
    reg oddeven;        // 01: 1 odd, 0 even
    reg active;         // 00
} Scanline;

typedef struct packed {
    // ADV7513 configuration
    reg [7:0] adv_reg_01; // \
    reg [7:0] adv_reg_02; //  |--> audio clock regeneration N
    reg [7:0] adv_reg_03; // /
    reg [7:0] adv_reg_17; // 02: 16:9, 00: 4:3
    reg [7:0] adv_reg_56; // 28: 16:9, 18: 4:3
    reg [7:0] adv_reg_3b; // C8: input pll x2, 80: input pll x1
    reg [7:0] adv_reg_3c; // 00 | vic_manual
} ADV7513Config;

// typedef struct packed {
//     reg[7:0] offset;
// } Conf240p;
