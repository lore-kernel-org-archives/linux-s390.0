Return-Path: <SRS0=zbpt=TY=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH] KVM: selftests: enable pgste option for the linker on
 s390
References: <20190523164309.13345-1-thuth@redhat.com>
 <20190524103301.87017-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <be868d7d-0d18-6827-6f8a-3ef473db183d@redhat.com>
Date: Fri, 24 May 2019 21:07:23 +0200
MIME-Version: 1.0
In-Reply-To: <20190524103301.87017-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Shuah Khan <shuah@kernel.org>, Andrew Jones <drjones@redhat.com>, linux-kselftest@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 24.05.19 12:33, Christian Borntraeger wrote:
> To avoid testcase failures we need to enable the pgstes. This can be
> done with /proc/sys/vm/allocate_pgste or with a linker option that
> creates an  S390_PGSTE program header.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  tools/testing/selftests/kvm/Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index aef5bd1166cf..4aac14c1919f 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -44,7 +44,10 @@ CFLAGS += -O2 -g -std=gnu99 -fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE
>  no-pie-option := $(call try-run, echo 'int main() { return 0; }' | \
>          $(CC) -Werror $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -no-pie -x c - -o "$$TMP", -no-pie)
>  
> -LDFLAGS += -pthread $(no-pie-option)
> +# On s390, build the testcases KVM-enabled
> +pgste-option := $(call cc-ldoption, -Wl$(comma)--s390-pgste)
> +
> +LDFLAGS += -pthread $(no-pie-option) $(pgste-option)
>  
>  # After inclusion, $(OUTPUT) is defined and
>  # $(TEST_GEN_PROGS) starts with $(OUTPUT)/
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
