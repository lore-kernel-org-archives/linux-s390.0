Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4DF16CD1D
	for <linux-s390@vger.kernel.org>; Tue,  7 Jan 2025 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736245423; cv=none; b=KbhgxFOfc3HPePr5BOIvoXJ/sF9zrAScrH3VylVUi4tAwnIO8X0Rl1GDSrSq7A9W+7zQMUkrgqXzhzZUcfh/t9dEzCJZ70i1cnOhzHjrFNPEqNR7N8d2PlJDrm/MPvmH0oCl29aNX6Ss2Xra6nf35NyeG62I8ntN85+csMVDVyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736245423; c=relaxed/simple;
	bh=nCrYzYXtCZ52w+WMCVMGuzEepGMcH7jNv8JTBD/AzWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bIGfcrSh2ujZmVYONY56CxbFB0cudGovMA9Ma5inpL7BEM3uyLuTisxLnRi7zIOqlLm9J+SraF0r2pJYz/6pSmuAoITQH47MWCKoNd9wL7sWXY8CbKuHWumubE2uPkSRPFbqrlzuVFX1BogFQ9ph6H46Gd6FOtUdLvaxr0ZE1bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEkYVLVD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEkYVLVD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736245419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mcqeqEwe5iqR5Re7N7BvEtoAEPtydQAsKcQntG7WANE=;
	b=XEkYVLVDzvMIdWD9NKUs33RO0d51j4N+Y6x7wMKZ5J+YpnJBv3cIjNd03bPFvFxczp36ke
	PZlEYrPCcU4RNNoMHn5sUTcUDHE57+ixkjVxJj69UGlO7m1y7x81fY1tZDqsMSrWLr93UY
	axOZ9q/SVC4HthGTsyP+9cgbYlsA0io=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-50S0jIuVPT-bP4QH1dEWlg-1; Tue, 07 Jan 2025 05:23:38 -0500
X-MC-Unique: 50S0jIuVPT-bP4QH1dEWlg-1
X-Mimecast-MFC-AGG-ID: 50S0jIuVPT-bP4QH1dEWlg
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38a684a0971so1721072f8f.2
        for <linux-s390@vger.kernel.org>; Tue, 07 Jan 2025 02:23:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736245417; x=1736850217;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mcqeqEwe5iqR5Re7N7BvEtoAEPtydQAsKcQntG7WANE=;
        b=EL6SNYRAdnMqvQ+20JG2LczcIRnk0m/6EyoD76cfD1g2deAcQZi5JmUNMO8l4tXVog
         k08dFM7OhEVNDfmFxcZz+ER8nDt0aKbss4VPuKKgwtK58pMx3dD+50h5hiWA+4ZVjAHE
         bhoVgJQ3PsJ3wbmRsIpt5LE1cu4k3Bs3JL4yOC2nL4308v8azu1hhrZVgilaEHp+IiyU
         fPx8wIFWCyx7POEfS9Q7HsO542aPD0+Hw+3YwCWFoBd6o3vjMM1LlE6zDO6EAklYNS1X
         ZMBP75qP5IjiPskGbFX0w0Ms5lJYaP9rlWFXIqt/R3LMPUPN2pXqNvAZEsKs4k1Wv+ta
         31Gw==
X-Forwarded-Encrypted: i=1; AJvYcCXF0JBnBZI0xwy2YOpKJl8MT2IqUzde1lbB4Whs9CsS4IyrlSAJYzvfPrBkwO+RqNncfm6spsAT+rrl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+4Qmgb4ns0n4Hi9enV1B+e8THyLpPQAuiJ/QtBt4LJEqD6wRR
	s58Ea3lcqb89N/E99RngVe1n7omIw4Wb5v8aGdaTBQoFCofFThQByDukQnpTW6MCIYKFtkJSY7K
	nKcGDQGNezTXNJqLsmSrH2DVtmV1ASuLCS9GXJ89y0GesIdGEzg7ELrS4F0Q=
X-Gm-Gg: ASbGncvWiqsFzwoSBiccc6Glp5+bwoC+Vticuv82MEmv9k2PFnoRVWUK2XivMHF+b2s
	ZFGFio7AZdTUvDh2u5L5jKGyRIEprIAfK7cDzcm2V9sVfchcztHkc01kwaIR8JN9t/ISQpuTsSP
	ep7gP7LuF63hNdkPb4+xY19FYb5ptKnejpJ4rq8PcZ7sA1iTeF5vftMtzxtARA/EYZpn3YSYIKF
	ENCleNmio5ctG6hBJoM8umiHRESDyv7tMUjlY7rEuNLZj3ed8hYItCoHVzjME/wluDPXyD9T/pa
	mbabGw5Vu8sh2+g38wtVzoqjyn63Dqww0ncRiOIVluEsJJIUyplBpoOgDdYkRJEMI/LEjKJ5vSE
	lKM1DMpCg
X-Received: by 2002:adf:a341:0:b0:38a:4b8b:c57a with SMTP id ffacd0b85a97d-38a4b8bc5d9mr27546440f8f.44.1736245417090;
        Tue, 07 Jan 2025 02:23:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEo38TOPPHSUHNZ7QeyScsqvJgwGpjmS3y1MnqEbJv3n6GuGt02EA6LZCPV7zbqe+OWfX2/Vw==
X-Received: by 2002:adf:a341:0:b0:38a:4b8b:c57a with SMTP id ffacd0b85a97d-38a4b8bc5d9mr27546423f8f.44.1736245416779;
        Tue, 07 Jan 2025 02:23:36 -0800 (PST)
Received: from ?IPV6:2003:cb:c719:1700:56dc:6a88:b509:d3f3? (p200300cbc719170056dc6a88b509d3f3.dip0.t-ipconnect.de. [2003:cb:c719:1700:56dc:6a88:b509:d3f3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828cc8sm49988013f8f.17.2025.01.07.02.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 02:23:35 -0800 (PST)
Message-ID: <f87de820-0f72-4246-899d-0a27b32f691c@redhat.com>
Date: Tue, 7 Jan 2025 11:23:34 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] s390: Remove uses of page->index
To: Claudio Imbrenda <imbrenda@linux.ibm.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-s390@vger.kernel.org
References: <20241219162252.1025317-1-willy@infradead.org>
 <20250103155356.01c50a59@p-imbrenda>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250103155356.01c50a59@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.01.25 15:53, Claudio Imbrenda wrote:
> On Thu, 19 Dec 2024 16:22:48 +0000
> "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
>> These two patches compile ... I can promise nothing more than that.
> 
> hi,
> 
> I appreciate the effort, but I'm actually working on a series to
> completely stop using page->index and page->lru . It works, only needs
> reviews and some proper testing; I will send it out next week.
> 
> if David can send a polished version of his patch, I can pick it,
> otherwise I'll polish the WIP he has already sent.
> 
> @David: can you please polish and resend your patch?

Yes, I can send an official patch today.

-- 
Cheers,

David / dhildenb

