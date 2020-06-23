Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: linux-next: umh: fix processed error when UMH_WAIT_PROC is used
 seems to break linux bridge on s390x (bisected)
From: Christian Borntraeger <borntraeger@de.ibm.com>
References: <20200610154923.27510-5-mcgrof@kernel.org>
 <20200623141157.5409-1-borntraeger@de.ibm.com>
Message-ID: <b7d658b9-606a-feb1-61f9-b58e3420d711@de.ibm.com>
Date: Tue, 23 Jun 2020 16:23:22 +0200
MIME-Version: 1.0
In-Reply-To: <20200623141157.5409-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: mcgrof@kernel.org
Cc: ast@kernel.org, axboe@kernel.dk, bfields@fieldses.org, bridge@lists.linux-foundation.org, chainsaw@gentoo.org, christian.brauner@ubuntu.com, chuck.lever@oracle.com, davem@davemloft.net, dhowells@redhat.com, gregkh@linuxfoundation.org, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, josh@joshtriplett.org, keescook@chromium.org, keyrings@vger.kernel.org, kuba@kernel.org, lars.ellenberg@linbit.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, nikolay@cumulusnetworks.com, philipp.reisner@linbit.com, ravenexp@gmail.com, roopa@cumulusnetworks.com, serge@hallyn.com, slyfox@gentoo.org, viro@zeniv.linux.org.uk, yangtiezhu@loongson.cn, netdev@vger.kernel.org, markward@linux.ibm.com, linux-s390 <linux-s390@vger.kernel.org>



On 23.06.20 16:11, Christian Borntraeger wrote:
> Jens Markwardt reported a regression in the linux-next runs.  with "umh: fix
> processed error when UMH_WAIT_PROC is used" (from linux-next) a linux bridge
> with an KVM guests no longer activates :
> 
> without patch
> # ip addr show dev virbr1
> 6: virbr1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
>     link/ether 52:54:00:1e:3f:c0 brd ff:ff:ff:ff:ff:ff
>     inet 192.168.254.254/24 brd 192.168.254.255 scope global virbr1
>        valid_lft forever preferred_lft forever
> 
> with this patch the bridge stays DOWN with NO-CARRIER
> 
> # ip addr show dev virbr1
> 6: virbr1: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
>     link/ether 52:54:00:1e:3f:c0 brd ff:ff:ff:ff:ff:ff
>     inet 192.168.254.254/24 brd 192.168.254.255 scope global virbr1
>        valid_lft forever preferred_lft forever
> 
> This was bisected in linux-next. Reverting from linux-next also fixes the issue.
> 
> Any idea?

FWIW, s390 is big endian. Maybe some of the shifts inn the __KW* macros are wrong.
