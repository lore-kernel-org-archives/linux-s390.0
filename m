Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28388 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726261AbgDQDM3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Apr 2020 23:12:29 -0400
Subject: Re: [PATCH V2] vhost: do not enable VHOST_MENU by default
References: <20200415024356.23751-1-jasowang@redhat.com>
 <20200416185426-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b7e2deb7-cb64-b625-aeb4-760c7b28c0c8@redhat.com>
Date: Fri, 17 Apr 2020 11:12:14 +0800
MIME-Version: 1.0
In-Reply-To: <20200416185426-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, geert@linux-m68k.org, tsbogend@alpha.franken.de, benh@kernel.crashing.org, paulus@samba.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, Michael Ellerman <mpe@ellerman.id.au>


On 2020/4/17 =E4=B8=8A=E5=8D=886:55, Michael S. Tsirkin wrote:
> On Wed, Apr 15, 2020 at 10:43:56AM +0800, Jason Wang wrote:
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
>> Acked-by: Christian Borntraeger<borntraeger@de.ibm.com>  (s390)
>> Acked-by: Michael Ellerman<mpe@ellerman.id.au>  (powerpc)
>> Cc: Thomas Bogendoerfer<tsbogend@alpha.franken.de>
>> Cc: Benjamin Herrenschmidt<benh@kernel.crashing.org>
>> Cc: Paul Mackerras<paulus@samba.org>
>> Cc: Michael Ellerman<mpe@ellerman.id.au>
>> Cc: Heiko Carstens<heiko.carstens@de.ibm.com>
>> Cc: Vasily Gorbik<gor@linux.ibm.com>
>> Cc: Christian Borntraeger<borntraeger@de.ibm.com>
>> Reported-by: Geert Uytterhoeven<geert@linux-m68k.org>
>> Signed-off-by: Jason Wang<jasowang@redhat.com>
> I rebased this on top of OABI fix since that
> seems more orgent to fix.
> Pushed to my vhost branch pls take a look and
> if possible test.
> Thanks!


I test this patch by generating the defconfigs that wants vhost_net or=20
vhost_vsock. All looks fine.

But having CONFIG_VHOST_DPN=3Dy may end up with the similar situation tha=
t=20
this patch want to address.

Maybe we can let CONFIG_VHOST depends on !ARM || AEABI then add another=20
menuconfig for VHOST_RING and do something similar?

Thanks
