Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E54F1DED5B
	for <linux-s390@vger.kernel.org>; Fri, 11 Jul 2025 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752233562; cv=none; b=ZzvbRrkZ2LW9hYyeIq49bBrNI/deC0i342Ma3Il5N9wo3qZfi03AjFzmdnOL0MgozufAk41/tdfq46jYpthpKss37W/4Klb69ossPdKZMNtQfiBXjciQRXsKegN42O6oHcS1MvcM+5xaoCUtVjGjg5I6C48dx5yt/ZvY2FiMxp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752233562; c=relaxed/simple;
	bh=BZCvv/2hXsvGb//PtywPu9ICAftZQyJos5tYaQ8MH0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qZuV1LCfO/wAwo84dalRldqYmLBmc2J+omoMr7xXetl522uYrQ47JipQY5yBn4O50xTsKBYM7VOLe6VATYMarFRHN8kaXk8fuIGaa2A8PQAICBDk5NHvCrsxt/7M+p/cQN/PsnOxiIJXSjSsC3od43Z/qowl0dkf8hOb8danLeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bzIWP2tn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzIWP2tn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752233559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rBaMeUalwqPGHF1pXuNNlqoOhLhH/XgvIyFgh+zaVmk=;
	b=bzIWP2tndwrpfLntciHmC7Ids+RwLi2qqR8f9kT7KiiwWgml1ItpN/Z5BInLNEKOFUtxmG
	DBW7+asXLzgkVejXXwPxOur2f4rldFmtFkr6f0fuYqBBxY7rlgyBcYipILBL5avSZGrzic
	DUx/prDBHXVmsOAEMw6EZr4hW+/1n8g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-6_kRCas-OPOfd6FSNhXpPQ-1; Fri, 11 Jul 2025 07:32:38 -0400
X-MC-Unique: 6_kRCas-OPOfd6FSNhXpPQ-1
X-Mimecast-MFC-AGG-ID: 6_kRCas-OPOfd6FSNhXpPQ_1752233557
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4532514dee8so15984325e9.0
        for <linux-s390@vger.kernel.org>; Fri, 11 Jul 2025 04:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752233557; x=1752838357;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rBaMeUalwqPGHF1pXuNNlqoOhLhH/XgvIyFgh+zaVmk=;
        b=Ke9U8x7LNeT2+MNvU3Wc7mxUkCou4Qmh4qGX2ijuNrdhhW+XY3LoB6JU3y25kVf1gN
         I+CsX6tK0tZNBOsz89WGLGqR5zbk5358wTWGOKa/Y8o6cPUP/dMySEdv6bXK0t5JXI2y
         8FD3ugFiP3K9knEbxsxaERfR6sDtCn409PditA9PiTKMkxQQUnR3cWrleQ+NrMsUCWOr
         Md1Mdx+Yanmr3DfGz2wFTQmcuxsPByDtxu07CDDyK7hnvjsAH59+TXw7Mt0xjM4d1Lub
         IESlwF33RaGmUOkTDXfRjkjx4BPReJ/sipBes2970jd1xwFLcXUIwBGhGLOets6i4Ok8
         Wuqw==
X-Forwarded-Encrypted: i=1; AJvYcCUnl0sJWlLreX00v9Ya59K0Fk9YtRvzbcnJul1dAwScnXZFDMe6mhnzbR3qkk1IKuttJ5vTf60iT2zA@vger.kernel.org
X-Gm-Message-State: AOJu0YxfEK9JaESsX5V/CTApOc1wUoMQGwvnZijzKR2oSViskx4G2gyX
	XbWmQXpU0x28CwL7fqLRhrVItj5Mr691rqI8HIi/mYson17yTPzz0mDHxDmexBq/4e4PL8DMUWU
	nYVnOFWw1fEw5Id7Wm0zkUwCulx3Pth5afVMLfbR+8gwG7g3CPrzOV02Vum/jgoc=
X-Gm-Gg: ASbGncsLW9Y36532O0bJJykPQgQtsqW3w1TvrqJkgsphWGRduYRdlWRmTaLQRhDlFs9
	EPoaBpQ669fq8fTvttoSDVUy2wSLucZz5Qagbub384A43XOYDmebGOsZMn/lfz/8VPN+/ZHNqL6
	M9La/eAIewwnrD6RDmcWYoJymrW2bF3fQtbpYoaoD18CqxAEES/OO/obHZLGxnp9d0DDTmEQm0s
	qqRgFpqXjo51ZDaWp7mx0OLJZkGF214meQkmV4v/SiEH5GnWI8bNpefG8ZDvjY5lJNqlta3UKkI
	eqOQPBHq6vR7YR7hSf+6AXIa8mNRMZ5tyLN6AOrEVy52dzVa8jFa+1S6VMacqGHIxCh1l0fPdza
	CTFPP
X-Received: by 2002:a05:600c:1549:b0:43d:300f:fa1d with SMTP id 5b1f17b1804b1-454f425585amr28408725e9.31.1752233556750;
        Fri, 11 Jul 2025 04:32:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE61oWTKweMEXZfo4uTm9GgpnpWiVgolfLMo+v8sGn4fN8oDtJ8j83cwuweqsXezmErlhJuKA==
X-Received: by 2002:a05:600c:1549:b0:43d:300f:fa1d with SMTP id 5b1f17b1804b1-454f425585amr28408305e9.31.1752233556153;
        Fri, 11 Jul 2025 04:32:36 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-149.pools.arcor-ip.net. [47.64.115.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5032ff4sm83722835e9.8.2025.07.11.04.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 04:32:35 -0700 (PDT)
Message-ID: <ce92db8c-6d26-4953-9f74-142d00d2bc2a@redhat.com>
Date: Fri, 11 Jul 2025 13:32:33 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v4 07/13] scripts: Add default arguments
 for kvmtool
To: Alexandru Elisei <alexandru.elisei@arm.com>, andrew.jones@linux.dev,
 eric.auger@redhat.com, lvivier@redhat.com, frankja@linux.ibm.com,
 imbrenda@linux.ibm.com, nrb@linux.ibm.com, david@redhat.com,
 pbonzini@redhat.com
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, will@kernel.org, julien.thierry.kdev@gmail.com,
 maz@kernel.org, oliver.upton@linux.dev, suzuki.poulose@arm.com,
 yuzenghui@huawei.com, joey.gouly@arm.com, andre.przywara@arm.com,
 shahuang@redhat.com, Boqiao Fu <bfu@redhat.com>
References: <20250625154813.27254-1-alexandru.elisei@arm.com>
 <20250625154813.27254-8-alexandru.elisei@arm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 xsFNBFH7eUwBEACzyOXKU+5Pcs6wNpKzrlJwzRl3VGZt95VCdb+FgoU9g11m7FWcOafrVRwU
 yYkTm9+7zBUc0sW5AuPGR/dp3pSLX/yFWsA/UB4nJsHqgDvDU7BImSeiTrnpMOTXb7Arw2a2
 4CflIyFqjCpfDM4MuTmzTjXq4Uov1giGE9X6viNo1pxyEpd7PanlKNnf4PqEQp06X4IgUacW
 tSGj6Gcns1bCuHV8OPWLkf4hkRnu8hdL6i60Yxz4E6TqlrpxsfYwLXgEeswPHOA6Mn4Cso9O
 0lewVYfFfsmokfAVMKWzOl1Sr0KGI5T9CpmRfAiSHpthhHWnECcJFwl72NTi6kUcUzG4se81
 O6n9d/kTj7pzTmBdfwuOZ0YUSqcqs0W+l1NcASSYZQaDoD3/SLk+nqVeCBB4OnYOGhgmIHNW
 0CwMRO/GK+20alxzk//V9GmIM2ACElbfF8+Uug3pqiHkVnKqM7W9/S1NH2qmxB6zMiJUHlTH
 gnVeZX0dgH27mzstcF786uPcdEqS0KJuxh2kk5IvUSL3Qn3ZgmgdxBMyCPciD/1cb7/Ahazr
 3ThHQXSHXkH/aDXdfLsKVuwDzHLVSkdSnZdt5HHh75/NFHxwaTlydgfHmFFwodK8y/TjyiGZ
 zg2Kje38xnz8zKn9iesFBCcONXS7txENTzX0z80WKBhK+XSFJwARAQABzR5UaG9tYXMgSHV0
 aCA8dGh1dGhAcmVkaGF0LmNvbT7CwXgEEwECACIFAlVgX6oCGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAAoJEC7Z13T+cC21EbIP/ii9cvT2HHGbFRl8HqGT6+7Wkb+XLMqJBMAIGiQK
 QIP3xk1HPTsLfVG0ao4hy/oYkGNOP8+ubLnZen6Yq3zAFiMhQ44lvgigDYJo3Ve59gfe99KX
 EbtB+X95ODARkq0McR6OAsPNJ7gpEUzfkQUUJTXRDQXfG/FX303Gvk+YU0spm2tsIKPl6AmV
 1CegDljzjycyfJbk418MQmMu2T82kjrkEofUO2a24ed3VGC0/Uz//XCR2ZTo+vBoBUQl41BD
 eFFtoCSrzo3yPFS+w5fkH9NT8ChdpSlbNS32NhYQhJtr9zjWyFRf0Zk+T/1P7ECn6gTEkp5k
 ofFIA4MFBc/fXbaDRtBmPB0N9pqTFApIUI4vuFPPO0JDrII9dLwZ6lO9EKiwuVlvr1wwzsgq
 zJTPBU3qHaUO4d/8G+gD7AL/6T4zi8Jo/GmjBsnYaTzbm94lf0CjXjsOX3seMhaE6WAZOQQG
 tZHAO1kAPWpaxne+wtgMKthyPLNwelLf+xzGvrIKvLX6QuLoWMnWldu22z2ICVnLQChlR9d6
 WW8QFEpo/FK7omuS8KvvopFcOOdlbFMM8Y/8vBgVMSsK6fsYUhruny/PahprPbYGiNIhKqz7
 UvgyZVl4pBFjTaz/SbimTk210vIlkDyy1WuS8Zsn0htv4+jQPgo9rqFE4mipJjy/iboDzsFN
 BFH7eUwBEAC2nzfUeeI8dv0C4qrfCPze6NkryUflEut9WwHhfXCLjtvCjnoGqFelH/PE9NF4
 4VPSCdvD1SSmFVzu6T9qWdcwMSaC+e7G/z0/AhBfqTeosAF5XvKQlAb9ZPkdDr7YN0a1XDfa
 +NgA+JZB4ROyBZFFAwNHT+HCnyzy0v9Sh3BgJJwfpXHH2l3LfncvV8rgFv0bvdr70U+On2XH
 5bApOyW1WpIG5KPJlDdzcQTyptOJ1dnEHfwnABEfzI3dNf63rlxsGouX/NFRRRNqkdClQR3K
 gCwciaXfZ7ir7fF0u1N2UuLsWA8Ei1JrNypk+MRxhbvdQC4tyZCZ8mVDk+QOK6pyK2f4rMf/
 WmqxNTtAVmNuZIwnJdjRMMSs4W4w6N/bRvpqtykSqx7VXcgqtv6eqoDZrNuhGbekQA0sAnCJ
 VPArerAZGArm63o39me/bRUQeQVSxEBmg66yshF9HkcUPGVeC4B0TPwz+HFcVhheo6hoJjLq
 knFOPLRj+0h+ZL+D0GenyqD3CyuyeTT5dGcNU9qT74bdSr20k/CklvI7S9yoQje8BeQAHtdV
 cvO8XCLrpGuw9SgOS7OP5oI26a0548M4KldAY+kqX6XVphEw3/6U1KTf7WxW5zYLTtadjISB
 X9xsRWSU+Yqs3C7oN5TIPSoj9tXMoxZkCIHWvnqGwZ7JhwARAQABwsFfBBgBAgAJBQJR+3lM
 AhsMAAoJEC7Z13T+cC21hPAQAIsBL9MdGpdEpvXs9CYrBkd6tS9mbaSWj6XBDfA1AEdQkBOn
 ZH1Qt7HJesk+qNSnLv6+jP4VwqK5AFMrKJ6IjE7jqgzGxtcZnvSjeDGPF1h2CKZQPpTw890k
 fy18AvgFHkVk2Oylyexw3aOBsXg6ukN44vIFqPoc+YSU0+0QIdYJp/XFsgWxnFIMYwDpxSHS
 5fdDxUjsk3UBHZx+IhFjs2siVZi5wnHIqM7eK9abr2cK2weInTBwXwqVWjsXZ4tq5+jQrwDK
 cvxIcwXdUTLGxc4/Z/VRH1PZSvfQxdxMGmNTGaXVNfdFZjm4fz0mz+OUi6AHC4CZpwnsliGV
 ODqwX8Y1zic9viSTbKS01ZNp175POyWViUk9qisPZB7ypfSIVSEULrL347qY/hm9ahhqmn17
 Ng255syASv3ehvX7iwWDfzXbA0/TVaqwa1YIkec+/8miicV0zMP9siRcYQkyTqSzaTFBBmqD
 oiT+z+/E59qj/EKfyce3sbC9XLjXv3mHMrq1tKX4G7IJGnS989E/fg6crv6NHae9Ckm7+lSs
 IQu4bBP2GxiRQ+NV3iV/KU3ebMRzqIC//DCOxzQNFNJAKldPe/bKZMCxEqtVoRkuJtNdp/5a
 yXFZ6TfE1hGKrDBYAm4vrnZ4CXFSBDllL59cFFOJCkn4Xboj/aVxxJxF30bn
In-Reply-To: <20250625154813.27254-8-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/06/2025 17.48, Alexandru Elisei wrote:
> kvmtool, unless told otherwise, will do its best to make sure that a kernel
> successfully boots in a virtual machine. It does things like automatically
> creating a rootfs and adding extra parameters to the kernel command line.
> This is actively harmful to kvm-unit-tests, because some tests parse the
> kernel command line and they will fail if they encounter the options added
> by kvmtool.
> 
> Fortunately for us, kvmtool commit 5613ae26b998 ("Add --nodefaults command
> line argument") addded the --nodefaults kvmtool parameter which disables
> all the implicit virtual machine configuration that cannot be disabled by
> using other parameters, like modifying the kernel command line. So always
> use --nodefaults to allow a test to run.
> 
> kvmtool can also be too verbose when running a virtual machine, and this is
> controlled by several parameters. Add those to the default kvmtool command
> line to reduce this verbosity to a minimum.
> 
> Before:
> 
> $ vm run arm/selftest.flat --cpus 2 --mem 256 --params "setup smp=2 mem=256"
> Info: # lkvm run -k arm/selftest.flat -m 256 -c 2 --name guest-5035
> Unknown subtest
> 
> EXIT: STATUS=127
> Warning: KVM compatibility warning.
>      virtio-9p device was not detected.
>      While you have requested a virtio-9p device, the guest kernel did not initialize it.
>      Please make sure that the guest kernel was compiled with CONFIG_NET_9P_VIRTIO=y enabled in .config.
> Warning: KVM compatibility warning.
>      virtio-net device was not detected.
>      While you have requested a virtio-net device, the guest kernel did not initialize it.
>      Please make sure that the guest kernel was compiled with CONFIG_VIRTIO_NET=y enabled in .config.
> Info: KVM session ended normally.
> 
> After:
> 
> $ vm run arm/selftest.flat --nodefaults --network mode=none --loglevel=warning --cpus 2 --mem 256 --params "setup smp=2 mem=256"
> PASS: selftest: setup: smp: number of CPUs matches expectation
> INFO: selftest: setup: smp: found 2 CPUs
> PASS: selftest: setup: mem: memory size matches expectation
> INFO: selftest: setup: mem: found 256 MB
> SUMMARY: 2 tests
> 
> EXIT: STATUS=1
> 
> Note that KVMTOOL_DEFAULT_OPTS can be overwritten by an environment
> variable with the same name, but it's not documented in the help string for
> run_tests.sh. This has been done on purpose, since overwritting
> KVMTOOL_DEFAULT_OPTS should only be necessary for debugging or development
> purposes.
> 
> Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
> 
> Changes v3->v4:
> 
> * Use vmm_default_opts() instead of indexing into vmm_optname
> * Reworded the help test for --nodefaults as per Shaoqin's suggestion.
> 
>   scripts/common.bash |  6 +++---
>   scripts/vmm.bash    | 18 ++++++++++++++++++
>   2 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/common.bash b/scripts/common.bash
> index 7c1b89f1b3c2..d5d3101c8089 100644
> --- a/scripts/common.bash
> +++ b/scripts/common.bash
> @@ -37,7 +37,7 @@ function for_each_unittest()
>   			# -append as a kernel parameter instead of a command
>   			# line option.
>   			test_args=""
> -			opts=""
> +			opts="$(vmm_default_opts)"
>   			groups=""
>   			arch=""
>   			machine=""
> @@ -51,7 +51,7 @@ function for_each_unittest()
>   		elif [[ $line =~ ^test_args\ *=\ *(.*)$ ]]; then
>   			test_args="$(vmm_optname_args) ${BASH_REMATCH[1]}"
>   		elif [[ $line =~ ^$params_name\ *=\ *'"""'(.*)$ ]]; then
> -			opts=${BASH_REMATCH[1]}$'\n'
> +			opts="$(vmm_defaults_opts) ${BASH_REMATCH[1]}$'\n'"
>   			while read -r -u $fd; do
>   				#escape backslash newline, but not double backslash
>   				if [[ $opts =~ [^\\]*(\\*)$'\n'$ ]]; then
> @@ -67,7 +67,7 @@ function for_each_unittest()
>   				fi
>   			done
>   		elif [[ $line =~ ^$params_name\ *=\ *(.*)$ ]]; then
> -			opts=${BASH_REMATCH[1]}
> +			opts="$(vmm_default_opts) ${BASH_REMATCH[1]}"
>   		elif [[ $line =~ ^groups\ *=\ *(.*)$ ]]; then
>   			groups=${BASH_REMATCH[1]}
>   		elif [[ $line =~ ^arch\ *=\ *(.*)$ ]]; then
> diff --git a/scripts/vmm.bash b/scripts/vmm.bash
> index 0dd3f971ecdf..368690d62473 100644
> --- a/scripts/vmm.bash
> +++ b/scripts/vmm.bash
> @@ -1,3 +1,14 @@
> +# The following parameters are enabled by default when running a test with
> +# kvmtool:
> +# --nodefaults: suppress VM configuration that cannot be disabled (like
> +#               modifying the supplied kernel command line). Otherwise tests
> +#               that use the command line will fail without this parameter.
> +# --network mode=none: do not create a network device. kvmtool tries to help the
> +#               user by automatically create one, and then prints a warning
> +#               when the VM terminates if the device hasn't been initialized.
> +# --loglevel=warning: reduce verbosity
> +: "${KVMTOOL_DEFAULT_OPTS:="--nodefaults --network mode=none --loglevel=warning"}"
> +
>   ##############################################################################
>   # qemu_fixup_return_code translates the ambiguous exit status in Table1 to that
>   # in Table2.  Table3 simply documents the complete status table.
> @@ -82,11 +93,13 @@ function kvmtool_fixup_return_code()
>   
>   declare -A vmm_optname=(
>   	[qemu,args]='-append'
> +	[qemu,default_opts]=''
>   	[qemu,fixup_return_code]=qemu_fixup_return_code
>   	[qemu,initrd]='-initrd'
>   	[qemu,nr_cpus]='-smp'
>   
>   	[kvmtool,args]='--params'
> +	[kvmtool,default_opts]="$KVMTOOL_DEFAULT_OPTS"
>   	[kvmtool,fixup_return_code]=kvmtool_fixup_return_code
>   	[kvmtool,initrd]='--initrd'
>   	[kvmtool,nr_cpus]='--cpus'
> @@ -97,6 +110,11 @@ function vmm_optname_args()
>   	echo ${vmm_optname[$(vmm_get_target),args]}
>   }
>   
> +function vmm_default_opts()
> +{
> +	echo ${vmm_optname[$(vmm_get_target),default_opts]}
> +}


This causes now a problem on s390x:

https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/jobs/10604334029#L591

scripts/common.bash: line 56: vmm_defaults_opts: command not found

... any ideas how to fix it?

  Thomas

