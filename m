Return-Path: <linux-kernel-owner+w=401wt.eu-S1754893AbXKFPKr@vger.kernel.org>
Message-ID: <473083CA.9060607@linux.vnet.ibm.com>
Date: Tue, 06 Nov 2007 20:40:02 +0530
From: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: mm snapshot broken-out-2007-11-06-02-32.tar.gz uploaded - S390x
 build fails
References: <200711061033.lA6AXrhT018804@imap1.linux-foundation.org>
In-Reply-To: <200711061033.lA6AXrhT018804@imap1.linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org, linux390@de.ibm.com, linux-s390@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Andrew,

The build fails on the S390x with 

 CC      drivers/s390/char/sclp_cpi_sys.o
drivers/s390/char/sclp_cpi_sys.c:242: error: variable `system_name_attr' has initializer but incomplete type
drivers/s390/char/sclp_cpi_sys.c:243: error: unknown field `attr' specified in initializer
drivers/s390/char/sclp_cpi_sys.c:243: error: extra brace group at end of initializer
drivers/s390/char/sclp_cpi_sys.c:243: error: (near initialization for `system_name_attr')
drivers/s390/char/sclp_cpi_sys.c:243: warning: excess elements in struct initializer
drivers/s390/char/sclp_cpi_sys.c:243: warning: (near initialization for `system_name_attr')
drivers/s390/char/sclp_cpi_sys.c:243: error: unknown field `show' specified in initializer
drivers/s390/char/sclp_cpi_sys.c:243: warning: excess elements in struct initializer
drivers/s390/char/sclp_cpi_sys.c:243: warning: (near initialization for `system_name_attr')
drivers/s390/char/sclp_cpi_sys.c:243: error: unknown field `store' specified in initializer
drivers/s390/char/sclp_cpi_sys.c:243: warning: excess elements in struct initializer
drivers/s390/char/sclp_cpi_sys.c:243: warning: (near initialization for `system_name_attr')
drivers/s390/char/sclp_cpi_sys.c:264: error: variable `sysplex_name_attr' has initializer but incomplete type
drivers/s390/char/sclp_cpi_sys.c:265: error: unknown field `attr' specified in initializer
drivers/s390/char/sclp_cpi_sys.c:265: error: extra brace group at end of initializer
drivers/s390/char/sclp_cpi_sys.c:265: error: (near initialization for `sysplex_name_attr')
drivers/s390/char/sclp_cpi_sys.c:265: warning: excess elements in struct initializer
drivers/s390/char/sclp_cpi_sys.c:265: warning: (near initialization for `sysplex_name_attr')
drivers/s390/char/sclp_cpi_sys.c:265: error: unknown field `show' specified in initializer
drivers/s390/char/sclp_cpi_sys.c:265: warning: excess elements in struct initializer
drivers/s390/char/sclp_cpi_sys.c:265: warning: (near initialization for `sysplex_name_attr')
drivers/s390/char/sclp_cpi_sys.c:265: error: unknown field `store' specified in initializer
drivers/s390/char/sclp_cpi_sys.c:265: warning: excess elements in struct initializer
drivers/s390/char/sclp_cpi_sys.c:265: warning: (near initialization for `sysplex_name_attr')
drivers/s390/char/sclp_cpi_sys.c:287: error: variable `system_type_attr' has initializer but incomplete type
drivers/s390/char/sclp_cpi_sys.c:288: error: unknown field `attr' specified in initializer
drivers/s390/char/sclp_cpi_sys.c:288: error: extra brace group at end of initializer
drivers/s390/char/sclp_cpi_sys.c:288: error: (near initialization for `system_type_attr')
drivers/s390/char/sclp_cpi_sys.c:288: warning: excess elements in struct initializer
drivers/s390/char/sclp_cpi_sys.c:288: warning: (near initialization for `system_type_attr')
drivers/s390/char/sclp_cpi_sys.c:288: error: unknown field `show' specified in initializer
drivers/s390/char/sclp_cpi_sys.c:288: warning: excess elements in struct initializer
drivers/s390/char/sclp_cpi_sys.c:288: warning: (near initialization for `system_type_attr')
drivers/s390/char/sclp_cpi_sys.c:288: error: unknown field `store' specified in initializer
drivers/s390/char/sclp_cpi_sys.c:288: warning: excess elements in struct initializer
drivers/s390/char/sclp_cpi_sys.c:288: warning: (near initialization for `system_type_attr')
drivers/s390/char/sclp_cpi_sys.c:317: error: variable `system_level_attr' has initializer but incomplete type
drivers/s390/char/sclp_cpi_sys.c:318: error: unknown field `attr' specified in initializer
drivers/s390/char/sclp_cpi_sys.c:318: error: extra brace group at end of initializer
drivers/s390/char/sclp_cpi_sys.c:318: error: (near initialization for `system_level_attr')
drivers/s390/char/sclp_cpi_sys.c:318: warning: excess elements in struct initializer
drivers/s390/char/sclp_cpi_sys.c:318: warning: (near initialization for `system_level_attr')
drivers/s390/char/sclp_cpi_sys.c:318: error: unknown field `show' specified in initializer
drivers/s390/char/sclp_cpi_sys.c:318: warning: excess elements in struct initializer
drivers/s390/char/sclp_cpi_sys.c:318: warning: (near initialization for `system_level_attr')
drivers/s390/char/sclp_cpi_sys.c:318: error: unknown field `store' specified in initializer
drivers/s390/char/sclp_cpi_sys.c:318: warning: excess elements in struct initializer
drivers/s390/char/sclp_cpi_sys.c:318: warning: (near initialization for `system_level_attr')
drivers/s390/char/sclp_cpi_sys.c:333: error: variable `set_attr' has initializer but incomplete type
drivers/s390/char/sclp_cpi_sys.c:334: error: unknown field `attr' specified in initializer
drivers/s390/char/sclp_cpi_sys.c:334: error: extra brace group at end of initializer
drivers/s390/char/sclp_cpi_sys.c:334: error: (near initialization for `set_attr')
drivers/s390/char/sclp_cpi_sys.c:334: warning: excess elements in struct initializer
drivers/s390/char/sclp_cpi_sys.c:334: warning: (near initialization for `set_attr')
drivers/s390/char/sclp_cpi_sys.c:334: error: unknown field `show' specified in initializer
drivers/s390/char/sclp_cpi_sys.c:334: warning: excess elements in struct initializer
drivers/s390/char/sclp_cpi_sys.c:334: warning: (near initialization for `set_attr')
drivers/s390/char/sclp_cpi_sys.c:334: error: unknown field `store' specified in initializer
drivers/s390/char/sclp_cpi_sys.c:334: warning: excess elements in struct initializer
drivers/s390/char/sclp_cpi_sys.c:334: warning: (near initialization for `set_attr')
drivers/s390/char/sclp_cpi_sys.c:337: error: invalid use of undefined type `struct subsys_attribute'
drivers/s390/char/sclp_cpi_sys.c:337: error: initializer element is not constant
drivers/s390/char/sclp_cpi_sys.c:337: error: (near initialization for `cpi_attrs[0]')
drivers/s390/char/sclp_cpi_sys.c:338: error: invalid use of undefined type `struct subsys_attribute'
drivers/s390/char/sclp_cpi_sys.c:338: error: initializer element is not constant
drivers/s390/char/sclp_cpi_sys.c:338: error: (near initialization for `cpi_attrs[1]')
drivers/s390/char/sclp_cpi_sys.c:339: error: invalid use of undefined type `struct subsys_attribute'
drivers/s390/char/sclp_cpi_sys.c:339: error: initializer element is not constant
drivers/s390/char/sclp_cpi_sys.c:339: error: (near initialization for `cpi_attrs[2]')
drivers/s390/char/sclp_cpi_sys.c:340: error: invalid use of undefined type `struct subsys_attribute'
drivers/s390/char/sclp_cpi_sys.c:340: error: initializer element is not constant
drivers/s390/char/sclp_cpi_sys.c:340: error: (near initialization for `cpi_attrs[3]')
drivers/s390/char/sclp_cpi_sys.c:341: error: invalid use of undefined type `struct subsys_attribute'
drivers/s390/char/sclp_cpi_sys.c:341: error: initializer element is not constant
drivers/s390/char/sclp_cpi_sys.c:341: error: (near initialization for `cpi_attrs[4]')
drivers/s390/char/sclp_cpi_sys.c:349: error: syntax error before '(' token
drivers/s390/char/sclp_cpi_sys.c: In function `cpi_init':
drivers/s390/char/sclp_cpi_sys.c:379: error: implicit declaration of function `firmware_register'
drivers/s390/char/sclp_cpi_sys.c:379: error: `cpi_subsys' undeclared (first use in this function)
drivers/s390/char/sclp_cpi_sys.c:379: error: (Each undeclared identifier is reported only once
drivers/s390/char/sclp_cpi_sys.c:379: error: for each function it appears in.)
drivers/s390/char/sclp_cpi_sys.c:385: error: implicit declaration of function `firmware_unregister'
drivers/s390/char/sclp_cpi_sys.c: At top level:
drivers/s390/char/sclp_cpi_sys.c:242: error: storage size of `system_name_attr' isn't known
drivers/s390/char/sclp_cpi_sys.c:264: error: storage size of `sysplex_name_attr' isn't known
drivers/s390/char/sclp_cpi_sys.c:287: error: storage size of `system_type_attr' isn't known
drivers/s390/char/sclp_cpi_sys.c:317: error: storage size of `system_level_attr' isn't known
drivers/s390/char/sclp_cpi_sys.c:333: error: storage size of `set_attr' isn't known
make[2]: *** [drivers/s390/char/sclp_cpi_sys.o] Error 1
make[1]: *** [drivers/s390/char] Error 2
make: *** [drivers/s390] Error 2

The patch git-s390.patch is causing this failure.
-- 
Thanks & Regards,
Kamalesh Babulal,
Linux Technology Center,
IBM, ISTL.
