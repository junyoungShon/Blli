package kr.co.blli.model.vo;

public class BlliUserExceptionLogVO {
	private int number;
	private String startBorder;
	private String endBorder;
	private String methodName;
	private String occuredTime;
	private String exceptionContent;
	private String className;
	public BlliUserExceptionLogVO() {
		super();
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
	public String getStartBorder() {
		return startBorder;
	}
	public void setStartBorder(String startBorder) {
		this.startBorder = startBorder;
	}
	public String getEndBorder() {
		return endBorder;
	}
	public void setEndBorder(String endBorder) {
		this.endBorder = endBorder;
	}
	public String getMethodName() {
		return methodName;
	}
	public void setMethodName(String methodName) {
		this.methodName = methodName;
	}
	public String getOccuredTime() {
		return occuredTime;
	}
	public void setOccuredTime(String occuredTime) {
		this.occuredTime = occuredTime;
	}
	public String getExceptionContent() {
		return exceptionContent;
	}
	public void setExceptionContent(String exceptionContent) {
		this.exceptionContent = exceptionContent;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	@Override
	public String toString() {
		return "BlliUserExceptionLogVO [number=" + number + ", startBorder="
				+ startBorder + ", endBorder=" + endBorder + ", methodName="
				+ methodName + ", occuredTime=" + occuredTime
				+ ", exceptionContent=" + exceptionContent + ", className="
				+ className + "]";
	}
	
}
