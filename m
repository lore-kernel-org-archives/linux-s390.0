From: "jamesmikedupont@googlemail.com" <jamesmikedupont@googlemail.com>
Date: Tue, 05 Oct 2010 08:01:17 +0000
Subject: state of the gcc on s390x?
Message-Id: <AANLkTi=cCnSdwPFdJauRcy_kWS3OLeEwJP-OK9QU9htk@mail.gmail.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi,
I was lucky to get an account on the ibm servers, .zseriespenguins.ihost.com.

I would like to compile the newer gcc, and the associated gmp, mpc, mpfr.

Does anyone have the lastest versions running?
What are the versions known to work?

Can I download a binary of gcc 4.4 or later somewhere for the s390x?

I have this machine :
Linux 2.6.9-42.EL #1 SMP Wed Jul 12 23:21:43 EDT 2006 s390x s390x
s390x GNU/Linux

I am trying with these versions :
mpc-0.8.2
gmp-5.0.1
mpfr-3.0.0
and gcc lastest.

Andreas has given me a tip already for this
http://article.gmane.org/gmane.comp.lib.gmp.general/2611

But from what I can see it is a 64 bit machine,
and the problem I am having is that the macro in gmp in longlong.h is
defined only for 32 bits.
The macros/functions are
 smul_ppmm
and
 sdiv_qrnnd dont seem to be defined for 64 bits on gmp.

http://www.spinics.net/lists/linux-s390/msg02533.html

please advise...
thanks,
mike



-- 
James Michael DuPont
Member of Free Libre Open Source Software Kosova and Albania
flossk.org flossal.org
