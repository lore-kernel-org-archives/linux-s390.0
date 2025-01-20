Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15071B87EE
	for <linux-s390@vger.kernel.org>; Mon, 20 Jan 2025 12:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737375159; cv=none; b=c4yjlmEOjtqH5U0bLVRZJ4LTmDdxJCWS5u0BnFYI7u/exFXzC9RfFPY5tDUqLI5Wp98Rg4CJFfTTPDBXAC/0cP8cAILUUS9CRY6bLIOqUHznaVREBH+chd16qOGW+owSNoYCHV1hsuqXgJrV6RVmx+E1fpopkjjv59988qmkhgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737375159; c=relaxed/simple;
	bh=sy5YIFdgxvVuYN4Kim5frO7IlmzLY6Xq07Re7/Ebv1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcMYnG1S+A6SarxNjlZfmxQwlFNondsWij1PvEMbloNFZOpNLWIfFRJFXnDLg0ikchCyhDaHyVOSv4IGP6efjgma3cTt4c0K1aKo7scJ8abCX6O/xShRJX4kRiyOEp/2hS2JsJvlipGZQG3C5VZXOGnXFty79HgFbhwRwaKGUvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vlhz/33R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vlhz/33R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737375156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=yvc/rKaknr027b8OD1G2lVqE5SB9wTxU5u6APXZx1no=;
	b=Vlhz/33RR36WOlTfTmA2O9gU2qUvZuzbZ4rl5mV4Sgtict0CHNzxslGSiQBRn/G/GevAAy
	9AsjFKgsfzjfwQTHgceqtkhQ2ggUpokCF8m8rZe8jlwbF7O/7mGV176z28ac9TsOPI4dAv
	jsDdtu2FFDwYAVXwh4h8E6kt2I6JCOM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-yiIdMJ9mNeuenDrdyIwXhQ-1; Mon, 20 Jan 2025 07:12:35 -0500
X-MC-Unique: yiIdMJ9mNeuenDrdyIwXhQ-1
X-Mimecast-MFC-AGG-ID: yiIdMJ9mNeuenDrdyIwXhQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3860bc1d4f1so2845485f8f.2
        for <linux-s390@vger.kernel.org>; Mon, 20 Jan 2025 04:12:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737375154; x=1737979954;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yvc/rKaknr027b8OD1G2lVqE5SB9wTxU5u6APXZx1no=;
        b=nMETfygOJG1aItBuPFmlL5GK2s5+1MgPQi18Ls5L6HJIcHEL9qa8W5QkxKsqJVuN1m
         He2Tw5f2PwBh6pFoIxTt1y8KtIFPFgX5URFXk1kmHRMsSkFdCaK3TPmJlrEq8MsJxOAC
         biarspDdufRBYI4aIMYoF3mEsHeLvzzSk1MTB2GpBtsaYjT94erThIAaMdaZprhVibrv
         zAr/g5VnBkI+CzaDcjo4IrlKFVSxGkjnPM1PyBLrCLw2I4Hz73dWSObN24bZUlWY1Xgj
         VKtbpryeoBmuKypH9qR1cU1QpDr1r+twg468DZQvkE9O8+kGdUBt9nDGdP0/RtQ0kh9L
         w4LA==
X-Gm-Message-State: AOJu0Yx56WyqF4rxiJlTbFW9ihJNv2W2yLl9FH3A7ZD5XrrN+LmaN2Do
	dzIYbIHbmV3fOHeCL5Pc2xxguga/t7VEQUQHcD6Nz0U2RNl2juRtNhGxdrwKaF3a0NsSvaLldJA
	b6AsWU19a056eJnZ3ggqUmAaxSBSflOJed5Zk2wHH57dCqifQqfyJiS2pUX0=
X-Gm-Gg: ASbGncs4J6tm6X5ctW11U6NGhuduqq3YIT82PMSqGz3n4cUKfEJJDvALWeQb7xah0Vg
	qxhF7uOrK5GJ8aSGm1lrRWoRx7/cZ5GLCi6afGLHTOmwG+diCug8t3VNtn6y0zgI6zv/2QbnAI4
	orjnAuT893QqlAULEfVC5nGg19SNdF54HLSLOd2j/kFzGrfOS6bttsh1JJ0bR/lptxXKbI/7WHy
	djwj1K3bVbw9mx3yEnZGGlQgURhjYNtyF2PZbhAj78T0dSFuHQPeSR7/xXdJDSTkGuuys5zg5V2
	FD48YuGQ3gvDn4XZKp0sH3BjveUUIqNdJxRNm3A4SFxY9M20UE/k3XjZhhdD7odsieUKOpQ7n0m
	xiBdwojBTs7qLf2pUYmoDOQ==
X-Received: by 2002:a5d:5f56:0:b0:385:e176:4420 with SMTP id ffacd0b85a97d-38bf567800cmr12372161f8f.10.1737375154296;
        Mon, 20 Jan 2025 04:12:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1KNkr7rj8dqOTj7FeoFqku6VN4kPdczGEFkNYq9SPK+CkFWF+zzK0CUnl6OSTBuEdcuB/hQ==
X-Received: by 2002:a5d:5f56:0:b0:385:e176:4420 with SMTP id ffacd0b85a97d-38bf567800cmr12372125f8f.10.1737375153926;
        Mon, 20 Jan 2025 04:12:33 -0800 (PST)
Received: from ?IPV6:2003:d8:2f22:1000:d72d:fd5f:4118:c70b? (p200300d82f221000d72dfd5f4118c70b.dip0.t-ipconnect.de. [2003:d8:2f22:1000:d72d:fd5f:4118:c70b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c74ac5f9sm193321095e9.11.2025.01.20.04.12.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 04:12:32 -0800 (PST)
Message-ID: <19a46e9e-afbd-4f83-894d-e3331c3ac956@redhat.com>
Date: Mon, 20 Jan 2025 13:12:31 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/15] KVM: s390: selftests: fix ucontrol memory region
 test
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com,
 borntraeger@de.ibm.com, schlameuss@linux.ibm.com, willy@infradead.org,
 hca@linux.ibm.com, svens@linux.ibm.com, agordeev@linux.ibm.com,
 gor@linux.ibm.com, nrb@linux.ibm.com, nsg@linux.ibm.com, seanjc@google.com,
 seiden@linux.ibm.com
References: <20250117190938.93793-1-imbrenda@linux.ibm.com>
 <20250117190938.93793-5-imbrenda@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250117190938.93793-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.01.25 20:09, Claudio Imbrenda wrote:
> With the latest patch, attempting to create a memslot from userspace
> will result in an EEXIST error for UCONTROL VMs, instead of EINVAL,
> since the new memslot will collide with the internal memslot. There is
> no simple way to bring back the previous behaviour.
> 
> This is not a problem, but the test needs to be fixed accordingly.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>   tools/testing/selftests/kvm/s390x/ucontrol_test.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/s390x/ucontrol_test.c b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> index 135ee22856cf..ca18736257f8 100644
> --- a/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> +++ b/tools/testing/selftests/kvm/s390x/ucontrol_test.c
> @@ -459,10 +459,12 @@ TEST_F(uc_kvm, uc_no_user_region)
>   	};
>   
>   	ASSERT_EQ(-1, ioctl(self->vm_fd, KVM_SET_USER_MEMORY_REGION, &region));
> -	ASSERT_EQ(EINVAL, errno);
> +	if (errno != EEXIST)
> +		ASSERT_EQ(EINVAL, errno);

ASSERT_TRUE(errno == EEXIST || errno == EINVAL)'

?

-- 
Cheers,

David / dhildenb

