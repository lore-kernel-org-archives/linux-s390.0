From: Halil Pasic <pasic@linux.vnet.ibm.com>
Subject: Re: [PATCH] drivers/s390/virtio: Remove the old KVM virtio transport
Date: Wed, 27 Sep 2017 16:35:58 +0200
Message-ID: <1753dedc-ecd2-3404-3a52-8493ef5e9ade@linux.vnet.ibm.com>
References: <1506512521-2244-1-git-send-email-thuth@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1506512521-2244-1-git-send-email-thuth@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 09/27/2017 01:42 PM, Thomas Huth wrote:
> There is no recent user space application available anymore which still
> supports this old virtio transport. Additionally, commit 3b2fbb3f06ef
> ("virtio/s390: deprecate old transport") introduced a deprecation message
> in the driver, and apparently nobody complained so far that it is still
> required. So let's simply remove it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
(with or without the fixup))
