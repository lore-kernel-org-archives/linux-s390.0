From: Stefan Weinhuber <WEIN@de.ibm.com>
Date: Wed, 28 May 2014 14:46:06 +0000
Subject: Re: dasd HDIO_GETGEO
Message-Id: <OF4579C1BF.AC54EC3B-ONC1257CE6.004F1653-C1257CE6.00512046@de.ibm.com>
In-Reply-To: <20140528121208.GE385@x2.net.home>
References: <20140528121208.GE385@x2.net.home>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Karel,

Karel Zak <kzak@redhat.com> wrote on 2014-05-28 14:12:08:
> 
>  but only dasd driver overwrites this default and reports in native
>  sectors:
> 
>  drivers/s390/block/dasd.c: dasd_getgeo():
> 
>            geo->start = get_start_sect(bdev) >> base->block->s2b_shift;
> 
> 
>  So, for normal SCSI I always get start sector independently on disk
>  sector size, but for dasd... 
> 
>  Is it expected behavior? It's painful for userspace to care about 
>  driver type. 

I looked up that line in old change logs, and apparently this was
changed in 2002 during the Kernel 2.5 development phase with the
commit message

Fixed HDIO_GETGEO to meet 2.4 semantics

So this was an intentional change to remain compatible with older
versions of this ioctl.

> 
> 
>  (Well, HDIO_GETGEO sucks in many ways, so recommendation is to read
>   /sys/dev/block/<maj:min>/start rather than depends on this ioctl.)
> 
>     Karel
> 
> -- 
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
> 

Mit freundlichen Gr��en / Kind regards
 
Stefan Weinhuber
