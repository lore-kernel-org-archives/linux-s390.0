From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Wed, 27 Jan 2016 13:21:57 +0000
Subject: Re: linux-4.5-rc1/drivers/s390/net/netiucv.c:305: possible missing code ?
Message-Id: <1453900917.3891.8.camel@BR9GV9YG.de.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2016-01-25 at 08:34 +0000, David Binderman wrote:
> Hello there,
> 
> [linux-4.5-rc1/drivers/s390/net/netiucv.c:305] -> [linux-4.5-rc1/drivers/s390/net/netiucv.c:306]:
> (performance) Buffer 'tmp_uid' is being written before its old content has been used.
> 
> Source code is
> 
>         memcpy(tmp_uid, conn->userid, 8);
>         memcpy(tmp_uid, netiucv_printname(tmp_uid, 8), 8);
>         memcpy(tmp_udat, conn->userdata, 16);
>         EBCASC(tmp_udat, 16);
>         memcpy(tmp_udat, netiucv_printname(tmp_udat, 16), 16);
>         sprintf(buf, "%s.%s", tmp_uid, tmp_udat);
>         return buf;
> 
> Regards
> 
> David Binderman
> 
>  		 	   		  
David,

in your subject you suspect missing code here. That's not the case; it
is working this way, but I admit we can get rid of one memcpy line here.
I will take care about this later on.

Thanks, Ursula
