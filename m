From: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH v6 00/11] s390: channel I/O support in qemu.
Date: Thu, 24 Jan 2013 15:08:56 +0100
Message-ID: <CC7EA022-3287-42F0-B98D-DC0DA107B63A@suse.de>
References: <1359030491-46725-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1359030491-46725-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, =?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>
List-ID: <linux-s390.vger.kernel.org>


On 24.01.2013, at 13:28, Cornelia Huck wrote:

> Hi,
> 
> another round for virtual channel I/O in qemu.
> 
> The patches have been respun against current master; changelogs
> are in the patches themselves.
> 
> Changes are mostly some cleanups; of note are the preparations
> for VirtioBus and some changes for making the code endianness
> aware.
> 
> Making s390-ccw-virtio the default machine has been deferred until
> after tcg support is available.

Thanks, applied [01..07], 09 to s390-next.


Alex
