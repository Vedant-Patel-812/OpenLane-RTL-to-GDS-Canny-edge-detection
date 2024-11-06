module canny_edge(
    input clk,
    input rst,
    input [7:0] PixelData,
    output [11:0] out_data_el
);

wire [7:0] out_data1_lb514, out_data2_lb514, out_data3_lb514;
line_buffer_514 lb_gauss(clk, rst, 1'b1, PixelData, out_data1_lb514, out_data2_lb514, out_data3_lb514);


wire [7:0] out_data_gauss;
//wire beat_gauss;
gauss gauss_1(clk, rst, out_data1_lb514, out_data2_lb514, out_data3_lb514, out_data_gauss);


wire [7:0] out_data1_lb512, out_data2_lb512, out_data3_lb512, out_data4_lb512, out_data5_lb512;
line_buffer_512 lb_sobel(clk, rst, 1'b1, out_data_gauss, out_data1_lb512, out_data2_lb512, out_data3_lb512, out_data4_lb512, out_data5_lb512);


wire [19:0] out_data_gxy;
wire [1:0] out_data_ang;
//wire beat_sobel;
sobel_top sobel_1(clk, rst, out_data1_lb512, out_data2_lb512, out_data3_lb512, out_data4_lb512, out_data5_lb512, out_data_gxy, out_data_ang);


// wire [19:0] out_thresh_val;
//integer out_buff_thresh;
//integer out_buff_ang;
// reg [19:0] last_thresh;
// wire last_thresh;
// assign last_thresh = 200;
// thresh_cont thresh_1(clk, rst, en_th, out_data_gxy, out_thresh_val);


wire [19:0] out_data1_lb508, out_data2_lb508, out_data3_lb508; 
wire [1:0] out_data_ang_lb508;
line_buffer_508 lb_nmh(clk, rst, 1'b1, out_data_gxy, out_data_ang, out_data1_lb508, out_data2_lb508, out_data3_lb508, out_data_ang_lb508);

wire [2:0] out_data_nmh;
//wire beat_nmh;
non_max_hyst nmh_1(clk, rst, out_data1_lb508, out_data2_lb508, out_data3_lb508, out_data_ang_lb508, out_data_nmh);

wire [2:0] out_data1_lb506, out_data2_lb506, out_data3_lb506;
line_buffer_506 lb_el(clk, rst, 1'b1, out_data_nmh, out_data1_lb506, out_data2_lb506, out_data3_lb506);

//wire beat_el;
edge_linking el_1(clk, rst, out_data1_lb506, out_data2_lb506, out_data3_lb506, out_data_el);

//reg [19:0] prev_frame_thresh_val;

endmodule

