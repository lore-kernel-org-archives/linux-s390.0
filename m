From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH/RFC 14/21] KVM: s390: clear the pfault queue if user space
 sets the invalid token
Date: Mon, 19 Jan 2015 09:19:27 +0100
Message-ID: <54BCBE0F.3050604@de.ibm.com>
References: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com> <1421329414-76826-15-git-send-email-borntraeger@de.ibm.com> <20150117105009.GA12539@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20150117105009.GA12539@osiris>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Am 17.01.2015 um 11:50 schrieb Heiko Carstens:
[...]
>> +/* for KVM_SYNC_PFAULT and KVM_REG_S390_PFTOKEN */
>> +#define KVM_S390_PFAULT_TOKEN_INVALID	0xffffffffffffffffUL
> 
> uapi is for both 64 bit and (theoretically) also 32 bit. So this
> should be 0xfff...ffULL instead of UL to prevent a different compat
> ABI.

Thanks. Will fix up.

Christian
