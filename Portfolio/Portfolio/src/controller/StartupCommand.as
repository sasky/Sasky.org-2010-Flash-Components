package controller 
{
	import Model.ImagesProxy;
	import Model.WorksProxy;
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	import view.ApplicationMediator;
	
	/**
	 * ...
	 * @author sasky.org
	 */
	public class StartupCommand extends SimpleCommand implements ICommand
	{
		
		
		override public function execute(notification:INotification):void 
		{
			
			facade.registerProxy(new WorksProxy());
			facade.registerProxy(new ImagesProxy());
			
			facade.registerMediator(new ApplicationMediator( notification.getBody() as Main ));
		}
		
		
	}

}