Return-Path: <SRS0=Q8yj=TU=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [RFC PATCH 0/4] KVM selftests for s390x
References: <20190516111253.4494-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b412e591-3983-ebef-510b-43f9b7be4147@redhat.com>
Date: Mon, 20 May 2019 13:20:03 +0200
MIME-Version: 1.0
In-Reply-To: <20190516111253.4494-1-thuth@redhat.com>
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
> This patch series enables the KVM selftests for s390x. As a first
> test, the sync_regs from x86 has been adapted to s390x.
> 
> Please note that the ucall() interface is not used yet - since
> s390x neither has PIO nor MMIO, this needs some more work first
> before it becomes usable (we likely should use a DIAG hypercall
> here, which is what the sync_reg test is currently using, too...).

No objections at all, though it would be like to have ucall plumbed in
from the beginning.

Paolo
