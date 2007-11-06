Return-Path: <linux-kernel-owner+w=401wt.eu-S1757754AbXKFUQx@vger.kernel.org>
Date: Tue, 6 Nov 2007 13:10:37 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: mm snapshot broken-out-2007-11-06-02-32.tar.gz uploaded - S390x
 build fails
Message-Id: <20071106131037.ea014b48.akpm@linux-foundation.org>
In-Reply-To: <473083CA.9060607@linux.vnet.ibm.com>
References: <200711061033.lA6AXrhT018804@imap1.linux-foundation.org>
	<473083CA.9060607@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux390@de.ibm.com, linux-s390@vger.kernel.org, apw@shadowen.org, Greg KH <greg@kroah.com>
List-ID: <linux-s390.vger.kernel.org>

> On Tue, 06 Nov 2007 20:40:02 +0530 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:
> Hi Andrew,
> 
> The build fails on the S390x with 
> 
>  CC      drivers/s390/char/sclp_cpi_sys.o
> drivers/s390/char/sclp_cpi_sys.c:242: error: variable `system_name_attr' has initializer but incomplete type
> drivers/s390/char/sclp_cpi_sys.c:243: error: unknown field `attr' specified in initializer
> drivers/s390/char/sclp_cpi_sys.c:243: error: extra brace group at end of initializer
> drivers/s390/char/sclp_cpi_sys.c:243: error: (near initialization for `system_name_attr')
> drivers/s390/char/sclp_cpi_sys.c:243: warning: excess elements in struct initializer
> drivers/s390/char/sclp_cpi_sys.c:243: warning: (near initialization for `system_name_attr')
> drivers/s390/char/sclp_cpi_sys.c:243: error: unknown field `show' specified in initializer
> drivers/s390/char/sclp_cpi_sys.c:243: warning: excess elements in struct initializer
> drivers/s390/char/sclp_cpi_sys.c:243: warning: (near initialization for `system_name_attr')
> drivers/s390/char/sclp_cpi_sys.c:243: error: unknown field `store' specified in initializer
> drivers/s390/char/sclp_cpi_sys.c:243: warning: excess elements in struct initializer
> drivers/s390/char/sclp_cpi_sys.c:243: warning: (near initialization for `system_name_attr')
> drivers/s390/char/sclp_cpi_sys.c:264: error: variable `sysplex_name_attr' has initializer but incomplete type
> drivers/s390/char/sclp_cpi_sys.c:265: error: unknown field `attr' specified in initializer
> drivers/s390/char/sclp_cpi_sys.c:265: error: extra brace group at end of initializer
> drivers/s390/char/sclp_cpi_sys.c:265: error: (near initialization for `sysplex_name_attr')
> drivers/s390/char/sclp_cpi_sys.c:265: warning: excess elements in struct initializer
> drivers/s390/char/sclp_cpi_sys.c:265: warning: (near initialization for `sysplex_name_attr')
> drivers/s390/char/sclp_cpi_sys.c:265: error: unknown field `show' specified in initializer
> drivers/s390/char/sclp_cpi_sys.c:265: warning: excess elements in struct initializer
> drivers/s390/char/sclp_cpi_sys.c:265: warning: (near initialization for `sysplex_name_attr')
> drivers/s390/char/sclp_cpi_sys.c:265: error: unknown field `store' specified in initializer
> drivers/s390/char/sclp_cpi_sys.c:265: warning: excess elements in struct initializer
> drivers/s390/char/sclp_cpi_sys.c:265: warning: (near initialization for `sysplex_name_attr')
> drivers/s390/char/sclp_cpi_sys.c:287: error: variable `system_type_attr' has initializer but incomplete type
> drivers/s390/char/sclp_cpi_sys.c:288: error: unknown field `attr' specified in initializer
> drivers/s390/char/sclp_cpi_sys.c:288: error: extra brace group at end of initializer
> drivers/s390/char/sclp_cpi_sys.c:288: error: (near initialization for `system_type_attr')
> drivers/s390/char/sclp_cpi_sys.c:288: warning: excess elements in struct initializer
> drivers/s390/char/sclp_cpi_sys.c:288: warning: (near initialization for `system_type_attr')
> drivers/s390/char/sclp_cpi_sys.c:288: error: unknown field `show' specified in initializer
> drivers/s390/char/sclp_cpi_sys.c:288: warning: excess elements in struct initializer
> drivers/s390/char/sclp_cpi_sys.c:288: warning: (near initialization for `system_type_attr')
> drivers/s390/char/sclp_cpi_sys.c:288: error: unknown field `store' specified in initializer
> drivers/s390/char/sclp_cpi_sys.c:288: warning: excess elements in struct initializer
> drivers/s390/char/sclp_cpi_sys.c:288: warning: (near initialization for `system_type_attr')
> drivers/s390/char/sclp_cpi_sys.c:317: error: variable `system_level_attr' has initializer but incomplete type
> drivers/s390/char/sclp_cpi_sys.c:318: error: unknown field `attr' specified in initializer
> drivers/s390/char/sclp_cpi_sys.c:318: error: extra brace group at end of initializer
> drivers/s390/char/sclp_cpi_sys.c:318: error: (near initialization for `system_level_attr')
> drivers/s390/char/sclp_cpi_sys.c:318: warning: excess elements in struct initializer
> drivers/s390/char/sclp_cpi_sys.c:318: warning: (near initialization for `system_level_attr')
> drivers/s390/char/sclp_cpi_sys.c:318: error: unknown field `show' specified in initializer
> drivers/s390/char/sclp_cpi_sys.c:318: warning: excess elements in struct initializer
> drivers/s390/char/sclp_cpi_sys.c:318: warning: (near initialization for `system_level_attr')
> drivers/s390/char/sclp_cpi_sys.c:318: error: unknown field `store' specified in initializer
> drivers/s390/char/sclp_cpi_sys.c:318: warning: excess elements in struct initializer
> drivers/s390/char/sclp_cpi_sys.c:318: warning: (near initialization for `system_level_attr')
> drivers/s390/char/sclp_cpi_sys.c:333: error: variable `set_attr' has initializer but incomplete type
> drivers/s390/char/sclp_cpi_sys.c:334: error: unknown field `attr' specified in initializer
> drivers/s390/char/sclp_cpi_sys.c:334: error: extra brace group at end of initializer
> drivers/s390/char/sclp_cpi_sys.c:334: error: (near initialization for `set_attr')
> drivers/s390/char/sclp_cpi_sys.c:334: warning: excess elements in struct initializer
> drivers/s390/char/sclp_cpi_sys.c:334: warning: (near initialization for `set_attr')
> drivers/s390/char/sclp_cpi_sys.c:334: error: unknown field `show' specified in initializer
> drivers/s390/char/sclp_cpi_sys.c:334: warning: excess elements in struct initializer
> drivers/s390/char/sclp_cpi_sys.c:334: warning: (near initialization for `set_attr')
> drivers/s390/char/sclp_cpi_sys.c:334: error: unknown field `store' specified in initializer
> drivers/s390/char/sclp_cpi_sys.c:334: warning: excess elements in struct initializer
> drivers/s390/char/sclp_cpi_sys.c:334: warning: (near initialization for `set_attr')
> drivers/s390/char/sclp_cpi_sys.c:337: error: invalid use of undefined type `struct subsys_attribute'
> drivers/s390/char/sclp_cpi_sys.c:337: error: initializer element is not constant
> drivers/s390/char/sclp_cpi_sys.c:337: error: (near initialization for `cpi_attrs[0]')
> drivers/s390/char/sclp_cpi_sys.c:338: error: invalid use of undefined type `struct subsys_attribute'
> drivers/s390/char/sclp_cpi_sys.c:338: error: initializer element is not constant
> drivers/s390/char/sclp_cpi_sys.c:338: error: (near initialization for `cpi_attrs[1]')
> drivers/s390/char/sclp_cpi_sys.c:339: error: invalid use of undefined type `struct subsys_attribute'
> drivers/s390/char/sclp_cpi_sys.c:339: error: initializer element is not constant
> drivers/s390/char/sclp_cpi_sys.c:339: error: (near initialization for `cpi_attrs[2]')
> drivers/s390/char/sclp_cpi_sys.c:340: error: invalid use of undefined type `struct subsys_attribute'
> drivers/s390/char/sclp_cpi_sys.c:340: error: initializer element is not constant
> drivers/s390/char/sclp_cpi_sys.c:340: error: (near initialization for `cpi_attrs[3]')
> drivers/s390/char/sclp_cpi_sys.c:341: error: invalid use of undefined type `struct subsys_attribute'
> drivers/s390/char/sclp_cpi_sys.c:341: error: initializer element is not constant
> drivers/s390/char/sclp_cpi_sys.c:341: error: (near initialization for `cpi_attrs[4]')
> drivers/s390/char/sclp_cpi_sys.c:349: error: syntax error before '(' token
> drivers/s390/char/sclp_cpi_sys.c: In function `cpi_init':
> drivers/s390/char/sclp_cpi_sys.c:379: error: implicit declaration of function `firmware_register'
> drivers/s390/char/sclp_cpi_sys.c:379: error: `cpi_subsys' undeclared (first use in this function)
> drivers/s390/char/sclp_cpi_sys.c:379: error: (Each undeclared identifier is reported only once
> drivers/s390/char/sclp_cpi_sys.c:379: error: for each function it appears in.)
> drivers/s390/char/sclp_cpi_sys.c:385: error: implicit declaration of function `firmware_unregister'
> drivers/s390/char/sclp_cpi_sys.c: At top level:
> drivers/s390/char/sclp_cpi_sys.c:242: error: storage size of `system_name_attr' isn't known
> drivers/s390/char/sclp_cpi_sys.c:264: error: storage size of `sysplex_name_attr' isn't known
> drivers/s390/char/sclp_cpi_sys.c:287: error: storage size of `system_type_attr' isn't known
> drivers/s390/char/sclp_cpi_sys.c:317: error: storage size of `system_level_attr' isn't known
> drivers/s390/char/sclp_cpi_sys.c:333: error: storage size of `set_attr' isn't known
> make[2]: *** [drivers/s390/char/sclp_cpi_sys.o] Error 1
> make[1]: *** [drivers/s390/char] Error 2
> make: *** [drivers/s390] Error 2
> 
> The patch git-s390.patch is causing this failure.

git-s390 newly adds that file.  I suspect that this code works OK for the
s390 guys (they're using Linux).  But Greg's driver tree basically ports
their driver to Gregnux, in which nothing works any more.

Greg, this is turning into a bit of a trainwreck.  Can you please have a
think about how we can provide a bit of back-compatibility to ease this
transition rather than just trashing everything?
