Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151A8322528
	for <linux-s390@vger.kernel.org>; Tue,  9 Sep 2025 11:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418443; cv=none; b=BmpCKMO5zg/zHKaylF4N7pSybLo4T6ooULzJNNPNwgPFJHpKrM38HRj9kY8NwGR3P4PTaFSu+3aWvR9BQOW4OiKLuQvdP7CD+8s0ujQL/XmRlPnSbNwAUcmH+cLcmE9wJQ9mJJs3m33vYLy+NTE6pE+xUF2HaEhM59CjKzPGJ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418443; c=relaxed/simple;
	bh=AK81ttMRJkjVgQAQfhffdHNnm0Wxng4pupXNCYzY+pU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pc29aWzQ2RVmMYxN8Z8w1wCB2+r1FhJk92NzJk8xVO4nIqiVYP38U5o8qiNU0DjQIJ13JnqcZJAtxHGVs0aOxlZlq9W0Z7wtlOSighI9gwHf+HMdO6akp7croiV0j+Hdrm563FYvBLJQNcQ+HIb3qF9WJw4hVYjzKSXvtnrN8ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9QVvBSe; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9QVvBSe"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3381df3b950so38440191fa.0
        for <linux-s390@vger.kernel.org>; Tue, 09 Sep 2025 04:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757418440; x=1758023240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=s/sj0gwdntylgPmORPk0KCu95OOgGMaW8TiolxV4Afc=;
        b=S9QVvBSe3PO801idQMGysINIwoaWg/53bMLWgromBcAg4CH16zbLoX8V3wwzp9dFyG
         3Rb07W+k0QWRsPF7eBLWMvcsfkI+HmJqhHfZORZezBVQMsByVJxkUopjXWkxzn+zpWEa
         dVPaYQ2tlq7WvkmuZdcKSb4LG/FKuJPd2hWB+2M6hnozvm6iuBdorCVDwLrXEkNDsEzl
         rsshIobj5herLGPVEOj2hz6dY1F2RAsqfRVMgzzKuYqsGw6pdumcUDcxT7ezeL7nuQkI
         a81TtFgNyfHQ6rzJjKlXHA/p8AmJGpHHPQhr2NbKDThrcBzYkGUPGfZr5RP0BwwrQy6A
         /Pjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757418440; x=1758023240;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/sj0gwdntylgPmORPk0KCu95OOgGMaW8TiolxV4Afc=;
        b=so0r9IiWiRxRJg/9viDjbOktmV96pXwX6G5hUK59T2XMBZNFUiJymk1fyDhYjgumQJ
         9Ff732VMvEKMO/U3uH8aO0mWyof/m08khbzs7AfnBOk/DvDQYbt1sKcSBZZ1gd2nmLTq
         cuLKYIb+w8/mL9ya+l3VZTMBfG75NzN6dY+VvhHXUmg5S66rxyPhXit+zLxhBPzbkRDM
         WTjmSrZrZHdWFoQfKsxQmHEDW188oXhyn9q0LrMAy68dFV1NEU3IayTBK1MtIH1Y08EY
         9GcBHLOuJ9TgvYO/iuPZmnsNPUo5xBKcYMprX3wIM8SZ8KL8Jm8SvnepfTmOTW0QNOkh
         ySUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ2SvjTjeX1725ik4fM707XkahCOOxTbtkmI/zW5n8CjkjbhwbWSalZrqGi4dHqIVrZVu/NNazk8+a@vger.kernel.org
X-Gm-Message-State: AOJu0YwTd5ntgOPZ5+OOrh15/UNxr/b05/O7DDk4AHHIZA48kfoZKJUj
	kKMB1sDNkvYPp5yWGPA24XDlOEtZuxzDLhWRTqYEgx7PJlacMUOzr3PogEoSvhPs
X-Gm-Gg: ASbGnct+t8vUcGd+zFx7m0ZwKbR5y2PGGaplLzYDFchSKNzup2wRVrMb8WZ9lE5gT2C
	6gnntl/BFUSlUCCgkUg+RBcPT9Bo8Beb6MIWT6sUPto9NcU31aA0ZamuxRlVetOoTkDlE3eyA/c
	NmP7HmFSbipbyfA2QSEc4k4+rlxKkfqyf+9D2stQfa+X9Nf9+ws2AxkGfXJThu7EgUdOTE6KdLK
	eaR99rMpvHtPiVL6KWS8efp14koR83cG86GNfqptLdXL1uBPpIxedEOrw+nuH0dNoTC3tUij0T8
	fEDEpOSVoTEkEOLpTd1KGIO5bB38msvU5q5/eu00IMql3S0AQlKU2t5PxHdI0usUrt4DkWuIfGy
	vIQtyHFo9l/3qaSNTcCzivhv+HtIlXgXFxYMtPKE=
X-Google-Smtp-Source: AGHT+IEFU1vIIjZuXcg52uYPdAMiK2YxWCTGZtXOCPKb3QoPLzNmYdqrswfp/AQgBMJZvEhPSurXRQ==
X-Received: by 2002:a05:6402:270e:b0:629:949c:a667 with SMTP id 4fb4d7f45d1cf-629949cb089mr4633741a12.31.1757418428278;
        Tue, 09 Sep 2025 04:47:08 -0700 (PDT)
Received: from [192.168.1.236] ([176.74.141.242])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62bfe9a01b1sm1195390a12.5.2025.09.09.04.47.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 04:47:07 -0700 (PDT)
Message-ID: <3184e0b1-571f-4cf7-94ef-acca41c12b02@gmail.com>
Date: Tue, 9 Sep 2025 13:47:07 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] dm-integrity: asynchronous hash support
To: Ingo Franzki <ifranzki@linux.ibm.com>,
 Mikulas Patocka <mpatocka@redhat.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Eric Biggers <ebiggers@kernel.org>,
 dengler@linux.ibm.com, linux-s390@vger.kernel.org, dm-devel@lists.linux.dev,
 agk@redhat.com, snitzer@kernel.org
References: <20250908131642.385445532@debian4.vm>
 <3a6b6f8f-5205-459c-810a-2425aae92fc8@linux.ibm.com>
 <e1e420d5-dc00-14d0-fdef-635d6ef70811@redhat.com>
 <bb68f9d6-8180-4291-9e6b-33bbdcef780f@linux.ibm.com>
Content-Language: en-US
From: Milan Broz <gmazyland@gmail.com>
Autocrypt: addr=gmazyland@gmail.com; keydata=
 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
In-Reply-To: <bb68f9d6-8180-4291-9e6b-33bbdcef780f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/9/25 1:18 PM, Ingo Franzki wrote:
>> Please, revert my patches and run the same test on a clean 6.17.0-rc5 just
>> to verify that the patches do not introduce the bug.
> 
> With your patches reverted the combined mode fails the same way as with your patches.
> So they did not introduce the bug.

Please report it as cryptsetup issue with a reproducer so we can later check it.

Thanks.
Milan

