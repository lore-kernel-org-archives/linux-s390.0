From: Fengguang Wu <fengguang.wu@intel.com>
Date: Fri, 29 Mar 2013 02:58:38 +0000
Subject: drivers/base/regmap/regmap-irq.c:229:2: error: implicit declaration of function 'irq_set_chip'
Message-Id: <20130329025838.GE10831@localhost>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Greetings,

FYI, kernel build failed on s390 since

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux master
head:   9064171268d838b8f283fe111ef086b9479d059a
commit: 81380739516730124067576c9cc9f2418be5bf36 regmap: no need primary handler for nested irq
date:   7 months ago
config: make ARCH=s390 allmodconfig

All error/warnings:

   In file included from drivers/base/regmap/regmap-irq.c:22:0:
   drivers/base/regmap/internal.h:146:52: warning: 'struct regmap_config' declared inside parameter list [enabled by default]
   drivers/base/regmap/internal.h:146:52: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
   drivers/base/regmap/regmap-irq.c:26:18: error: field 'irq_chip' has incomplete type
   drivers/base/regmap/regmap-irq.c: In function 'irq_to_regmap_irq':
   drivers/base/regmap/regmap-irq.c:49:20: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c: At top level:
   drivers/base/regmap/regmap-irq.c:52:36: warning: 'struct irq_data' declared inside parameter list [enabled by default]
   drivers/base/regmap/regmap-irq.c: In function 'regmap_irq_lock':
   drivers/base/regmap/regmap-irq.c:54:9: error: implicit declaration of function 'irq_data_get_irq_chip_data' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c:54:35: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/base/regmap/regmap-irq.c: At top level:
   drivers/base/regmap/regmap-irq.c:59:43: warning: 'struct irq_data' declared inside parameter list [enabled by default]
   drivers/base/regmap/regmap-irq.c: In function 'regmap_irq_sync_unlock':
   drivers/base/regmap/regmap-irq.c:61:35: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/base/regmap/regmap-irq.c:66:13: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:78:25: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:79:16: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:81:14: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:92:13: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:98:4: error: implicit declaration of function 'irq_set_irq_wake' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c: At top level:
   drivers/base/regmap/regmap-irq.c:108:38: warning: 'struct irq_data' declared inside parameter list [enabled by default]
   drivers/base/regmap/regmap-irq.c: In function 'regmap_irq_enable':
   drivers/base/regmap/regmap-irq.c:110:35: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/base/regmap/regmap-irq.c:112:63: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:114:22: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:114:66: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c: At top level:
   drivers/base/regmap/regmap-irq.c:117:39: warning: 'struct irq_data' declared inside parameter list [enabled by default]
   drivers/base/regmap/regmap-irq.c: In function 'regmap_irq_disable':
   drivers/base/regmap/regmap-irq.c:119:35: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/base/regmap/regmap-irq.c:121:63: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:123:22: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:123:65: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c: At top level:
   drivers/base/regmap/regmap-irq.c:126:39: warning: 'struct irq_data' declared inside parameter list [enabled by default]
   drivers/base/regmap/regmap-irq.c: In function 'regmap_irq_set_wake':
   drivers/base/regmap/regmap-irq.c:128:35: warning: initialization makes pointer from integer without a cast [enabled by default]
   drivers/base/regmap/regmap-irq.c:130:63: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:132:14: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:136:23: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:137:16: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:140:23: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:141:15: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c: At top level:
   drivers/base/regmap/regmap-irq.c:148:21: error: variable 'regmap_irq_chip' has initializer but incomplete type
   drivers/base/regmap/regmap-irq.c:149:2: error: unknown field 'irq_bus_lock' specified in initializer
   drivers/base/regmap/regmap-irq.c:149:2: warning: excess elements in struct initializer [enabled by default]
   drivers/base/regmap/regmap-irq.c:149:2: warning: (near initialization for 'regmap_irq_chip') [enabled by default]
   drivers/base/regmap/regmap-irq.c:150:2: error: unknown field 'irq_bus_sync_unlock' specified in initializer
   drivers/base/regmap/regmap-irq.c:150:2: warning: excess elements in struct initializer [enabled by default]
   drivers/base/regmap/regmap-irq.c:150:2: warning: (near initialization for 'regmap_irq_chip') [enabled by default]
   drivers/base/regmap/regmap-irq.c:151:2: error: unknown field 'irq_disable' specified in initializer
   drivers/base/regmap/regmap-irq.c:151:2: warning: excess elements in struct initializer [enabled by default]
   drivers/base/regmap/regmap-irq.c:151:2: warning: (near initialization for 'regmap_irq_chip') [enabled by default]
   drivers/base/regmap/regmap-irq.c:152:2: error: unknown field 'irq_enable' specified in initializer
   drivers/base/regmap/regmap-irq.c:152:2: warning: excess elements in struct initializer [enabled by default]
   drivers/base/regmap/regmap-irq.c:152:2: warning: (near initialization for 'regmap_irq_chip') [enabled by default]
   drivers/base/regmap/regmap-irq.c:153:2: error: unknown field 'irq_set_wake' specified in initializer
   drivers/base/regmap/regmap-irq.c:153:2: warning: excess elements in struct initializer [enabled by default]
   drivers/base/regmap/regmap-irq.c:153:2: warning: (near initialization for 'regmap_irq_chip') [enabled by default]
   drivers/base/regmap/regmap-irq.c: In function 'regmap_irq_thread':
   drivers/base/regmap/regmap-irq.c:165:10: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:181:28: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:182:30: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:189:12: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:196:34: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:197:14: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:206:22: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:207:28: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:208:33: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:209:4: error: implicit declaration of function 'handle_nested_irq' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c:209:4: error: implicit declaration of function 'irq_find_mapping' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c:214:10: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c: In function 'regmap_irq_map':
   drivers/base/regmap/regmap-irq.c:228:2: error: implicit declaration of function 'irq_set_chip_data' [-Werror=implicit-function-declaration]
>> drivers/base/regmap/regmap-irq.c:229:2: error: implicit declaration of function 'irq_set_chip' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c:230:2: error: implicit declaration of function 'irq_set_nested_thread' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c:237:2: error: implicit declaration of function 'irq_set_noprobe' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c: At top level:
   drivers/base/regmap/regmap-irq.c:245:11: error: 'irq_domain_xlate_twocell' undeclared here (not in a function)
   drivers/base/regmap/regmap-irq.c: In function 'regmap_add_irq_chip':
   drivers/base/regmap/regmap-irq.c:272:22: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:273:11: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:275:11: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:276:11: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:281:3: error: implicit declaration of function 'irq_alloc_descs' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c:281:47: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:295:53: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:300:51: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:305:55: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:310:10: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:311:52: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:318:25: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:319:11: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:321:24: error: 'IRQCHIP_MASK_ON_SUSPEND' undeclared (first use in this function)
   drivers/base/regmap/regmap-irq.c:321:24: note: each undeclared identifier is reported only once for each function it appears in
   drivers/base/regmap/regmap-irq.c:322:10: error: 'IRQCHIP_SKIP_SET_WAKE' undeclared (first use in this function)
   drivers/base/regmap/regmap-irq.c:329:10: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:330:27: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:336:22: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:337:23: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:338:11: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:341:22: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:343:13: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:345:11: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:360:23: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:362:14: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:375:3: error: implicit declaration of function 'irq_domain_add_legacy' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c:376:13: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:379:3: error: implicit declaration of function 'irq_domain_add_linear' [-Werror=implicit-function-declaration]
   drivers/base/regmap/regmap-irq.c:380:13: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:389:12: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c: In function 'regmap_irq_get_virq':
   drivers/base/regmap/regmap-irq.c:455:17: error: dereferencing pointer to incomplete type
   drivers/base/regmap/regmap-irq.c:458:2: error: implicit declaration of function 'irq_create_mapping' [-Werror=implicit-function-declaration]
   cc1: some warnings being treated as errors

vim +/irq_set_chip +229 drivers/base/regmap/regmap-irq.c

f8beab2b Mark Brown   2011-10-28  222  
4af8be67 Mark Brown   2012-05-13  223  static int regmap_irq_map(struct irq_domain *h, unsigned int virq,
4af8be67 Mark Brown   2012-05-13  224  			  irq_hw_number_t hw)
4af8be67 Mark Brown   2012-05-13  225  {
4af8be67 Mark Brown   2012-05-13  226  	struct regmap_irq_chip_data *data = h->host_data;
4af8be67 Mark Brown   2012-05-13  227  
4af8be67 Mark Brown   2012-05-13 @228  	irq_set_chip_data(virq, data);
81380739 Yunfan Zhang 2012-09-08 @229  	irq_set_chip(virq, &data->irq_chip);
4af8be67 Mark Brown   2012-05-13  230  	irq_set_nested_thread(virq, 1);
4af8be67 Mark Brown   2012-05-13  231  
4af8be67 Mark Brown   2012-05-13  232  	/* ARM needs us to explicitly flag the IRQ as valid

---
0-DAY kernel build testing backend              Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
