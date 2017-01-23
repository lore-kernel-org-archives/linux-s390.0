From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: s390: Move two error code assignments in
 kvm_vm_ioctl_get_dirty_log()
Date: Mon, 23 Jan 2017 10:19:56 +0100
Message-ID: <5a595e1d-d59d-9289-2e9b-5bffb6fc6b12@redhat.com>
References: <70f41e59-d8a4-de42-6064-80ecf6acc065@users.sourceforge.net>
 <35411200-2bd6-1c65-7d7f-21a6353875ea@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <35411200-2bd6-1c65-7d7f-21a6353875ea@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, SF Markus Elfring <elfring@users.sourceforge.net>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 23/01/2017 09:22, Christian Borntraeger wrote:
> Patches that changes open coded things to common helpers or things like
> kmalloc_array where appropriate or things that make the code more robust
> are fine and welcome, but I am not going to take this as it just shuffles
> things around. It does not fix anything and it does not improve the code,
> but it certainly carries the risk of breaking something (yes in this case
> it looks perfectly fine, though).

Besides,

	r = -ESOMETHING;
	if (...)
		return r;

is the way it's done everywhere else in KVM.

Paolo
