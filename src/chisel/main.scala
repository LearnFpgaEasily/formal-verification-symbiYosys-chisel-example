import chisel3._
import chisel3.util._

class Counter(max_count: Int) extends Module {
    val io = IO(new Bundle{
        val enable  = Input(Bool())
        val count   = Output(UInt(log2Ceil(max_count).W))
        val pulse = Output(Bool())
    })

    val reg_count = RegInit(0.U(log2Ceil(max_count).W))
    when(io.enable){
        reg_count := Mux(reg_count===max_count.U, 0.U, reg_count+1.U)
    }
    io.count := reg_count
    io.pulse := reg_count === max_count.U

}

object Main extends App{
    (new chisel3.stage.ChiselStage).emitVerilog(new Counter(12), Array("--target-dir", "build/artifacts/netlist/"))
}