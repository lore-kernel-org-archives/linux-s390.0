Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54679 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2437779AbgDNJsW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Apr 2020 05:48:22 -0400
Subject: Re: [PATCH] vhost: do not enable VHOST_MENU by default
References: <20200414024438.19103-1-jasowang@redhat.com>
 <375181ee-08ec-77a6-2dfc-f3c9c26705a1@de.ibm.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <802e6da9-4827-a9a4-b409-f08a5de4e750@redhat.com>
Date: Tue, 14 Apr 2020 17:48:04 +0800
MIME-Version: 1.0
In-Reply-To: <375181ee-08ec-77a6-2dfc-f3c9c26705a1@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, mst@redhat.com
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, geert@linux-m68k.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>


On 2020/4/14 =E4=B8=8B=E5=8D=883:26, Christian Borntraeger wrote:
> On 14.04.20 04:44, Jason Wang wrote:
>> We try to keep the defconfig untouched after decoupling CONFIG_VHOST
>> out of CONFIG_VIRTUALIZATION in commit 20c384f1ea1a
>> ("vhost: refine vhost and vringh kconfig") by enabling VHOST_MENU by
>> default. Then the defconfigs can keep enabling CONFIG_VHOST_NET
>> without the caring of CONFIG_VHOST.
>>
>> But this will leave a "CONFIG_VHOST_MENU=3Dy" in all defconfigs and ev=
en
>> for the ones that doesn't want vhost. So it actually shifts the
>> burdens to the maintainers of all other to add "CONFIG_VHOST_MENU is
>> not set". So this patch tries to enable CONFIG_VHOST explicitly in
>> defconfigs that enables CONFIG_VHOST_NET and CONFIG_VHOST_VSOCK.
>>
>> Cc: Thomas Bogendoerfer<tsbogend@alpha.franken.de>
>> Cc: Benjamin Herrenschmidt<benh@kernel.crashing.org>
>> Cc: Paul Mackerras<paulus@samba.org>
>> Cc: Michael Ellerman<mpe@ellerman.id.au>
>> Cc: Heiko Carstens<heiko.carstens@de.ibm.com>
>> Cc: Vasily Gorbik<gor@linux.ibm.com>
>> Cc: Christian Borntraeger<borntraeger@de.ibm.com>
> Fine with me.
> s390 part
>
> Acked-by: Christian Borntraeger<borntraeger@de.ibm.com>
>
>   That was my first approach to get things fixed before I reported
> this to you.


Exactly.

Thanks

>
