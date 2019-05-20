Return-Path: <SRS0=Q8yj=TU=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [RFC PATCH 4/4] KVM: selftests: Add the sync_regs test for s390x
References: <20190516111253.4494-1-thuth@redhat.com>
 <20190516111253.4494-5-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3e462f1d-c9c0-ac26-ed59-182fbbf60340@redhat.com>
Date: Mon, 20 May 2019 13:19:40 +0200
MIME-Version: 1.0
In-Reply-To: <20190516111253.4494-5-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Andrew Jones <drjones@redhat.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 16/05/19 13:12, Thomas Huth wrote:
> +#define VCPU_ID 5
> +
> +static void guest_code(void)
> +{
> +	for (;;) {
> +		asm volatile ("diag 0,0,0x501");
> +		asm volatile ("ahi 11,1");
> +	}

I'd like this to use something like

	register u32 stage = 0 asm("11");
	...
	stage++

instead (yes, it should be fixed in x86 too).

Paolo
