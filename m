Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F0D42AB7;
	Mon,  3 Aug 2026 08:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747331; cv=none; b=pyL3Euf/JPQV5V12yA58nUKCxhJ2Z+4J1CzTInvuATcVSHYfnjvr71urL/Q/48EkwgXnsHYPuoOPt6ItcGaVnMCgbJ9Ufl8y5LXpIiUnedXX37q1NFkkntUfzRpxntDEb4BQbtHa41P5fvZOOY27RxUaSaBWH0hY6HLV+YMzrwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747331; c=relaxed/simple;
	bh=cKJDvn5YJCw5zMjj5ST3vV1BKOyM6lf4QfamlpYiIRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3tXS0qjc/DLRYlAHAJfRSMtvIC2d1cj9lgbGCik4GYxyQEGlhbDYaDWNmA5zKoZXwd6dDPcgdZpPHY3zj6LQsLzJlPU+RUpnqMnaVbQ4LhWZ4N7JZLKAxNAolv6fTlPFe/q6lxZ3JKBeOB8Kk3FacBErbNq388ZuZlmE90TWz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFsASIfG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFsASIfG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDCF1F000E9;
	Mon,  3 Aug 2026 08:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785747329;
	bh=MFYRuVGotRRV/Itr2HNCyDdiZPa8mRw+riWzrv18CkE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=XFsASIfG887MEylBFK/VV7zOG4pTZr7VkBRusfpGrMGat7arjNStYoDU4/FFoTOhw
	 o3EaUDv0YC/CES4rDGgAEkyO1A1XgXhRrWihJJqZi6fNNK1vZ7KdOTripqUyS5rcuN
	 fHSl2XK+YWLStdsn6SVuFT/LSPTxajLTOdLTLy9IYbhei7SnGc1YBXb72HK2Acw+k+
	 QZAuZZYOl549M12WWAHzbPdCnI8ZAb84rO69I4VC+eB2ogkdKZ9N92fwHqkffxKsn2
	 meCq+NUKjyyFLlKjf6H0eod/2PTP4y4CwNlwYKsNHwVyjIYiSzYapIrJMQyBmlY0uT
	 9Vb7fQ95lk2WA==
Message-ID: <0a9c8cc8-1fa7-4f4c-b7df-e847925c2b24@kernel.org>
Date: Mon, 3 Aug 2026 10:55:24 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: pull writability check to follow_pfnmap_start()
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>, Fei Li <fei1.li@intel.com>,
 Peter Xu <peterx@redhat.com>, linux-s390@vger.kernel.org,
 linux-mm@kvack.org, Sergio Lopez <slp@redhat.com>
References: <20260731160514.1101989-1-pbonzini@redhat.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20260731160514.1101989-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/31/26 18:05, Paolo Bonzini wrote:
> All callers of follow_pfnmap_start() except s390_pci_mmio_write() are
> following it, if they are doing a write, with a check that args.writable
> is true; for s390_pci_mmio_write() that's a bug.  Most of them return
> -EFAULT if it is not, but because follow_pfnmap_start() returned success,
> they do not attempt to upgrade the page from read-only to read-write
> with fixup_user_fault().
> 
> Pull the check directly into follow_pfnmap_start() through another
> input parameter args.write_fault; this eliminates the need to do it in
> the caller and, for callers that do use fixup_user_fault(), lets it
> attempt to upgrade the page.
> 
> The change in return code to -EFAULT is okay:
> 
> - s390 is the only one to have a functional change in this respect;
>   but EINVAL is only documented for "Invalid length argument", while
>   "The address in mmio_addr is invalid" should already return EFAULT
>   (https://www.man7.org/linux/man-pages/man2/s390_pci_mmio_read.2.html)
> 
> - for VFIO and ACRN, -EFAULT was returned already
> 
> - for KVM, -EFAULT is eaten
> 
> - for generic_access_phys() the caller is __access_remote_vm()
>   which does not care about the error code.
> 
> Reported-by: Sergio Lopez <slp@redhat.com>

Reported-by: without Fixes: is odd.

> Link: https://lore.kernel.org/kvm/CAAiTLFU1ALsDoJoKW3d9bUvv990AozAoX=bEHmfnG54qyBAHFg@mail.gmail.com/
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

[...]

> index 485df9c2dbdd..34c79b5fcb9b 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3136,9 +3136,12 @@ struct follow_pfnmap_args {
>  	 * Inputs:
>  	 * @vma: Pointer to @vm_area_struct struct
>  	 * @address: the virtual address to walk
> +	 * @write_fault: if true, fail with -EFAULT unless the mapping is

Just wondering whether EPERM would be better.

> +	 * writable
>  	 */
>  	struct vm_area_struct *vma;
>  	unsigned long address;
> +	bool write_fault;

"write_fault" is a rather odd name for this, given that this function will not
trigger a write fault.

You want something that matches FOLL_WRITE.

"write_access" / "check_writable" maybe?

-- 
Cheers,

David
