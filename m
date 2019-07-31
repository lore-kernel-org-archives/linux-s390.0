Return-Path: <linux-kselftest-owner@vger.kernel.org>
Subject: Re: [PATCH 2/2] KVM: selftests: Enable dirty_log_test on s390x
References: <20190730100112.18205-1-thuth@redhat.com>
 <20190730100112.18205-3-thuth@redhat.com>
 <20190730105721.z4zsul7uxl2igoue@kamzik.brq.redhat.com>
 <a9824265-daf8-db36-86b8-ad890dc73f14@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <afdf2b18-47fd-aa48-41b7-130122590068@redhat.com>
Date: Wed, 31 Jul 2019 14:58:23 +0200
MIME-Version: 1.0
In-Reply-To: <a9824265-daf8-db36-86b8-ad890dc73f14@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>, Andrew Jones <drjones@redhat.com>
Cc: kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>

On 31/07/19 10:19, Thomas Huth wrote:
>>> @@ -293,6 +341,10 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
>>>  	 * case where the size is not aligned to 64 pages.
>>>  	 */
>>>  	guest_num_pages = (1ul << (30 - guest_page_shift)) + 16;
>>> +#ifdef __s390x__
>>> +	/* Round up to multiple of 1M (segment size) */
>>> +	guest_num_pages = (guest_num_pages + 0xff) & ~0xffUL;
>> We could maybe do this for all architectures as well.
> It's really only needed on s390x, so I think we should keep the #ifdef here.

Yes, on non-s390 we should keep covering the case where the size is not
a multiple of BITS_PER_LONG.

Paolo
