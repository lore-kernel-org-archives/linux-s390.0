From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2] KVM: halt_polling: provide a way to qualify wakeups
 during poll
Date: Fri, 13 May 2016 14:02:18 +0200
Message-ID: <5735C24A.50302@redhat.com>
References: <1463134596-19470-1-git-send-email-borntraeger@de.ibm.com>
 <1463134596-19470-2-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1463134596-19470-2-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>



On 13/05/2016 12:16, Christian Borntraeger wrote:
> +config HAVE_KVM_INVALID_POLLS
> +       bool
> +

I'll change the config item to HAVE_KVM_INVALID_WAKEUPS, otherwise looks
good.

Paolo
