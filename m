Return-Path: <linux-kselftest-owner@vger.kernel.org>
Subject: Re: [PATCH 2/2] KVM: selftests: Enable dirty_log_test on s390x
References: <20190730100112.18205-1-thuth@redhat.com>
 <20190730100112.18205-3-thuth@redhat.com>
 <20190730105721.z4zsul7uxl2igoue@kamzik.brq.redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a9824265-daf8-db36-86b8-ad890dc73f14@redhat.com>
Date: Wed, 31 Jul 2019 10:19:57 +0200
MIME-Version: 1.0
In-Reply-To: <20190730105721.z4zsul7uxl2igoue@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Andrew Jones <drjones@redhat.com>
Cc: kvm@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, Peter Xu <peterx@redhat.com>

On 30/07/2019 12.57, Andrew Jones wrote:
> On Tue, Jul 30, 2019 at 12:01:12PM +0200, Thomas Huth wrote:
>> To run the dirty_log_test on s390x, we have to make sure that we
>> access the dirty log bitmap with little endian byte ordering and
>> we have to properly align the memslot of the guest.
>> Also all dirty bits of a segment are set once on s390x when one
>> of the pages of a segment are written to for the first time, so
>> we have to make sure that we touch all pages during the first
>> iteration to keep the test in sync here.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
[...]
>> diff --git a/tools/testing/selftests/kvm/dirty_log_test.c b/tools/testing/selftests/kvm/dirty_log_test.c
>> index ceb52b952637..7a1223ad0ff3 100644
>> --- a/tools/testing/selftests/kvm/dirty_log_test.c
>> +++ b/tools/testing/selftests/kvm/dirty_log_test.c
>> @@ -26,9 +26,22 @@
>>  /* The memory slot index to track dirty pages */
>>  #define TEST_MEM_SLOT_INDEX		1
>>  
>> +#ifdef __s390x__
>> +
>> +/*
>> + * On s390x, the ELF program is sometimes linked at 0x80000000, so we can
>> + * not use 0x40000000 here without overlapping into that region. Thus let's
>> + * use 0xc0000000 as base address there instead.
>> + */
>> +#define DEFAULT_GUEST_TEST_MEM		0xc0000000
> 
> I think both x86 and aarch64 should be ok with this offset. If testing
> proves it does, then we can just change it for all architecture.

Ok. It seems to work on x86 - could you please check aarch64, since I
don't have such a system available right now?

>> +/* Dirty bitmaps are always little endian, so we need to swap on big endian */
>> +#if defined(__s390x__)
>> +# define BITOP_LE_SWIZZLE	((BITS_PER_LONG-1) & ~0x7)
>> +# define test_bit_le(nr, addr) \
>> +	test_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
>> +# define set_bit_le(nr, addr) \
>> +	set_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
>> +# define clear_bit_le(nr, addr) \
>> +	clear_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
>> +# define test_and_set_bit_le(nr, addr) \
>> +	test_and_set_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
>> +# define test_and_clear_bit_le(nr, addr) \
>> +	test_and_clear_bit((nr) ^ BITOP_LE_SWIZZLE, addr)
>> +#else
>> +# define test_bit_le	test_bit
>> +# define set_bit_le	set_bit
>> +# define clear_bit_le	clear_bit
>> +# define test_and_set_bit_le	test_and_set_bit
>> +# define test_and_clear_bit_le	test_and_clear_bit
>> +#endif
> 
> nit: does the formatting above look right after applying the patch?

It looked ok to me, but I can add some more tabs to even make it nicer :)

>> @@ -293,6 +341,10 @@ static void run_test(enum vm_guest_mode mode, unsigned long iterations,
>>  	 * case where the size is not aligned to 64 pages.
>>  	 */
>>  	guest_num_pages = (1ul << (30 - guest_page_shift)) + 16;
>> +#ifdef __s390x__
>> +	/* Round up to multiple of 1M (segment size) */
>> +	guest_num_pages = (guest_num_pages + 0xff) & ~0xffUL;
> 
> We could maybe do this for all architectures as well.

It's really only needed on s390x, so I think we should keep the #ifdef here.

 Thomas
