Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28345 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726616AbgDQJsi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 17 Apr 2020 05:48:38 -0400
Subject: Re: [PATCH V2] vhost: do not enable VHOST_MENU by default
References: <20200416185426-mutt-send-email-mst@kernel.org>
 <b7e2deb7-cb64-b625-aeb4-760c7b28c0c8@redhat.com>
 <20200417022929-mutt-send-email-mst@kernel.org>
 <4274625d-6feb-81b6-5b0a-695229e7c33d@redhat.com>
 <20200417042912-mutt-send-email-mst@kernel.org>
 <fdb555a6-4b8d-15b6-0849-3fe0e0786038@redhat.com>
 <20200417044230-mutt-send-email-mst@kernel.org>
 <73843240-3040-655d-baa9-683341ed4786@redhat.com>
 <20200417050029-mutt-send-email-mst@kernel.org>
 <ce8a18e5-3c74-73cc-57c5-10c40af838a3@redhat.com>
 <20200417053803-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <71b98c3b-1a38-b9aa-149c-f48c92a77448@redhat.com>
Date: Fri, 17 Apr 2020 17:48:20 +0800
MIME-Version: 1.0
In-Reply-To: <20200417053803-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, geert@linux-m68k.org, tsbogend@alpha.franken.de, benh@kernel.crashing.org, paulus@samba.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, Michael Ellerman <mpe@ellerman.id.au>


On 2020/4/17 =E4=B8=8B=E5=8D=885:38, Michael S. Tsirkin wrote:
> On Fri, Apr 17, 2020 at 05:33:56PM +0800, Jason Wang wrote:
>> On 2020/4/17 =E4=B8=8B=E5=8D=885:01, Michael S. Tsirkin wrote:
>>>> There could be some misunderstanding here. I thought it's somehow si=
milar: a
>>>> CONFIG_VHOST_MENU=3Dy will be left in the defconfigs even if CONFIG_=
VHOST is
>>>> not set.
>>>>
>>>> Thanks
>>>>
>>> BTW do entries with no prompt actually appear in defconfig?
>>>
>> Yes. I can see CONFIG_VHOST_DPN=3Dy after make ARCH=3Dm68k defconfig
> You see it in .config right? So that's harmless right?


Yes.

Thanks
