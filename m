Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C811F3ED121
	for <linux-s390@vger.kernel.org>; Tue, 20 Jan 2026 22:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768949577; cv=none; b=MMgKUKEr+Kna9rfRDXzL9wJ88LvNwKQgZ60hHOw7ZKi53IidStiCShNGRsrppEPZk7bWTKZv7C3BzwsuG2QbrWYj5FfXl994R2tCRB39L5i7hUeSu29QEyvgjfAsbIadACruj6fj8gCNfIQpM9aD+XpvUu7RoTAR+7p2hdqumII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768949577; c=relaxed/simple;
	bh=qD/j26TG8QB/fvfqN+5aQUCl7c2plCaXil2V0bd2omE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KDlAQSuD9DpyOuu0waVHioo28BVko7VghGXB73ORsGXYtofCHFBMepYqN68ckwwBeFmy22p6vLYxPQZYkcGyTrhQurmiu8KT74GueouK9d8IXccA/id41HQ03MVTi7ImdGbGqCGrU5VwOIIThGRTb8Ef23QpY8+rAweXsXPBjk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O7TdXsoD; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O7TdXsoD"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4801c731d0aso35673405e9.1
        for <linux-s390@vger.kernel.org>; Tue, 20 Jan 2026 14:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768949571; x=1769554371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S4KjfyJdWQNEIqVWGJNO+4LCq8tlO+7CgBGNqDLqJz4=;
        b=O7TdXsoDSgf5/wS0w90/6Rq2mOajxhVz7XgLcJVAbWpYSeqzL8khoxytg7CC/2VcE4
         fg0vX9pPy07anYnnkD3oMavnlQv13XZ4NNJv6sxXikTFNh2KmElOZ8Zwy1a0MYq0Kew0
         0aKfUxlZmHaB1wpjHQIriTfxgMm0PV5E4sJ0+5zDCZD00J/3w79yXOaKkSIPMdGdskPh
         X8Onf+762IQSHyzBWOZ48qhljl5ZrMEH5S0zWX1kTpyTY5Qw1Qp2dj17Uz9y6yyiVQz5
         OrxWfMvmZdcAy/729ngHuktgoyNM4XlwxZYppwWoL9APa+6mlxE3W1ZxWq2roZXu/CAO
         fEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768949571; x=1769554371;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4KjfyJdWQNEIqVWGJNO+4LCq8tlO+7CgBGNqDLqJz4=;
        b=B8U2MDpYm+GvkdXJ/vZ1uQQjoTBW9ixSUJxQeSqOFj1KaCXVF93k2WrM2dUjpOXsZi
         AXYPiJfO/yXsyn15o3tX0lqfxoNzaV3prX0CHw0OUxnBoJq3Iu8qYm8N/685wKkVq00x
         Ih0OrgSkIWqWNj5C/6qweO0SbIBqNSXvh+gvHjfCP/ibVmxNRGvjIoNaWnTfNxEfBS20
         bO8OqvOs/CCO66UNo6wt/WO2pKVChLgE/cyQh+p6C9Gf4jPTCLS501mmRYBWgh3bth21
         PwKDuWpQ1vBDiwjZdNxtWnKrBum27DYrW9Ey2Fhg4HV0f8mbMumja7aczNTMtMtszizy
         E9PA==
X-Gm-Message-State: AOJu0YxkcI5PqImZOaGwOFAn2/zW7EQ1bSGjffTdGXRbkF/cSRWgtdiv
	eAvCvi4pqcyYRU/+EhozR9Knuedr4ZhAPjSHm8+mp4GkopjZkZjITj425sb5ZXrrNJfbm+Dlgdk
	kBvUZ
X-Gm-Gg: AY/fxX7dPwIJtvRqOW8ClunIR4szjPDw41Y8SwMGVyyhvZacIUe+0C4ooZTrnKcho4Y
	Jbsx8u7DvejI293XXLlRR4rwevLADzoV0c5RPZ6L9n9KStJlf2Fadsv3WklcvYSvQZZ47aYOe3N
	08YMvMBFj0lR11bKAZs8nWviIQrwsQXhwv9AKJsgEpVjKORLX5+fMMSQJWEEZfbemYy13lzrMGf
	Y+OWEgIhmbGFkknjIq7J2ETg7pJrJ4HDxzqGvSpJh7DBsMu9U4siKli2VHqrbLVL6SEefT228Po
	mGn1fNmQH022lCcHCnmyMbPjzHuDyuGrIvdX4eCas3M9Tn0px53TYSPGQN+Fa4hN7IGa2SOtEK/
	30r0I7dyxLN3ztCzJDijG5sVHXXV66cqYaW+hh6iFdaCet78mgqZS0fS3s4vKGMz3qGDPUo33sR
	fxMbD/vRK2fzAt99f+IIUEc5O62LPHuEzwl213t5k=
X-Received: by 2002:a05:600c:c178:b0:477:a977:b8c5 with SMTP id 5b1f17b1804b1-4801e34cd0emr235686375e9.31.1768949571510;
        Tue, 20 Jan 2026 14:52:51 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf355ca7sm13058529a12.27.2026.01.20.14.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 14:52:50 -0800 (PST)
Message-ID: <1218d786-ad7a-4971-9cd5-273232f62d79@suse.com>
Date: Wed, 21 Jan 2026 09:22:47 +1030
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix the folio leak on S390 hardware acceleration
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: linux-s390@vger.kernel.org
References: <bcf36edfb7ac3caf3373174e741bb29c0feb268b.1768802004.git.wqu@suse.com>
Content-Language: en-US
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <bcf36edfb7ac3caf3373174e741bb29c0feb268b.1768802004.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Adding S390 to the mailing list, I got the incorrect address in the 
initial patch.

Much appreciated if S390 people can give it a test.

Thanks,
Qu


在 2026/1/19 16:24, Qu Wenruo 写道:
> [BUG]
> After commit aa60fe12b4f4 ("btrfs: zlib: refactor S390x HW acceleration
> buffer preparation"), we no longer release the folio of the page cache
> of folio returned by btrfs_compress_filemap_get_folio() for S390
> hardware accerlation path.
> 
> [CAUSE]
> Before that commit, we call kumap_local() and folio_put() after handling
> each folio.
> 
> Although the timing is not ideal (it release previous folio at the
> beginning of the loop, and rely on some extra cleanup out of the loop),
> it at least handles the folio release correctly.
> 
> Meanwhile the refactored code is easier to read, it lacks the call to
> release the filemap folio.
> 
> [FIX]
> Add the missing folio_put() for copy_data_into_buffer().
> 
> Cc: linux-s390@vger.kernel.orgaa60fe12b4f49f49fc73e5023f8675e2df1f7805
> Fixes: aa60fe12b4f4 ("btrfs: zlib: refactor S390x HW acceleration buffer preparation")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/zlib.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/btrfs/zlib.c b/fs/btrfs/zlib.c
> index 6caba8be7c84..10ed48d4a846 100644
> --- a/fs/btrfs/zlib.c
> +++ b/fs/btrfs/zlib.c
> @@ -139,6 +139,7 @@ static int copy_data_into_buffer(struct address_space *mapping,
>   		data_in = kmap_local_folio(folio, offset);
>   		memcpy(workspace->buf + cur - filepos, data_in, copy_length);
>   		kunmap_local(data_in);
> +		folio_put(folio);
>   		cur += copy_length;
>   	}
>   	return 0;

