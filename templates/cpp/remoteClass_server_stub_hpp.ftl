${remoteClass.name}.hpp
/* Autogenerated with Kurento Idl */

#ifndef __${camelToUnderscore(remoteClass.name)}_HPP__
#define __${camelToUnderscore(remoteClass.name)}_HPP__

#include <jsoncpp/json/json.h>
#include <JsonRpcException.hpp>
#include <ObjectRegistrar.hpp>
#include <memory>
#include <vector>
<#if (remoteClass.extends)??>
#include "${remoteClass.extends.name}.hpp"
</#if>
<#if remoteClass.events[0] ?? >
<#list remoteClass.events as event>
#include "${event.name}.hpp"
</#list>
#include <sigc++/sigc++.h>
#include <EventHandler.hpp>
</#if>

namespace kurento {

<#list remoteClassDependencies(remoteClass) as dependency>
class ${dependency.name};
</#list>

class ${remoteClass.name}<#if remoteClass.extends??><#rt>
   <#lt> : public virtual ${remoteClass.extends.name}<#rt>
   <#else>
   <#lt> : public std::enable_shared_from_this<${remoteClass.name}><#rt>
   </#if> {

public:

  ${remoteClass.name} () {};
  virtual ~${remoteClass.name} () {};
  <#list remoteClass.methods as method><#rt>
  <#if method_index = 0 >

  </#if>
  virtual ${getCppObjectType(method.return,false)} ${method.name} (<#rt>
      <#lt><#list method.params as param>${getCppObjectType(param.type)} ${param.name}<#if param_has_next>, </#if></#list>) {throw "Not implemented";};
  </#list>

  virtual std::string getType () {
    return "${remoteClass.name}";
  }

  virtual std::string connect(const std::string &eventType, std::shared_ptr<EventHandler> handler);
  <#list remoteClass.events as event>
    <#if event_index = 0 >

    </#if>
  sigc::signal<void, ${event.name}> signal${event.name};
  </#list>

  class Factory : public virtual kurento::Factory
  {
  public:
    Factory () {};

    virtual std::string getName () {
      return "${remoteClass.name}";
    };

  private:

    virtual MediaObject * createObjectPointer (const Json::Value &params);

    <#list remoteClass.constructors as constructor><#rt>
    MediaObject * createObject (<#rt>
     <#lt><#list constructor.params as param><#rt>
        <#lt>${getCppObjectType(param.type, true)} ${param.name}<#rt>
        <#lt><#if param_has_next>, </#if><#rt>
     <#lt></#list>);
    </#list>

    class StaticConstructor
    {
    public:
      StaticConstructor();
    };

    static StaticConstructor staticConstructor;

  };

  class Invoker<#if remoteClass.extends??> : public virtual ${remoteClass.extends.name}::Invoker</#if>
  {
  public:
    Invoker() {};
    virtual void invoke (std::shared_ptr<MediaObject> obj,
        const std::string &methodName, const Json::Value &params,
        Json::Value &response);
  };

  virtual <#if remoteClass.extends??>MediaObject::</#if>Invoker &getInvoker() {
    return invoker;
  }

  private:
    Invoker invoker;

};

} /* kurento */

#endif /*  __${camelToUnderscore(remoteClass.name)}_HPP__ */
