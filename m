Return-Path: <SRS0=Q8yj=TU=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [RFC PATCH 0/4] KVM selftests for s390x
References: <20190516111253.4494-1-thuth@redhat.com>
 <b412e591-3983-ebef-510b-43f9b7be4147@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9423ba89-b10e-5e6e-3cc8-8088f3088233@redhat.com>
Date: Mon, 20 May 2019 13:30:31 +0200
MIME-Version: 1.0
In-Reply-To: <b412e591-3983-ebef-510b-43f9b7be4147@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 20/05/2019 13.20, Paolo Bonzini wrote:
> On 16/05/19 13:12, Thomas Huth wrote:
>> This patch series enables the KVM selftests for s390x. As a first
>> test, the sync_regs from x86 has been adapted to s390x.
>>
>> Please note that the ucall() interface is not used yet - since
>> s390x neither has PIO nor MMIO, this needs some more work first
>> before it becomes usable (we likely should use a DIAG hypercall
>> here, which is what the sync_reg test is currently using, too...).
> 
> No objections at all, though it would be like to have ucall plumbed in
> from the beginning.

I'm still looking at the ucall interface ... what I don't quite get yet
is the question why the ucall_type there is selectable during runtime?

Are there plans to have test that could either use UCALL_PIO or
UCALL_MMIO? If not, what about moving ucall_init() and ucall() to
architecture specific code in tools/testing/selftests/kvm/lib/aarch64/
and tools/testing/selftests/kvm/lib/x86_64 instead, and to remove the
ucall_type stuff again (so that x86 is hard-wired to PIO and aarch64
is hard-wired to MMIO)? ... then I could add a DIAG-based ucall
on s390x more easily, I think.

 Thomas
