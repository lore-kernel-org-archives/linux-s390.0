Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCB928EC8D
	for <linux-s390@vger.kernel.org>; Tue, 14 Jan 2025 09:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736847456; cv=none; b=gu+R+u+QVxKcpZf4PGTYeUMu0UzGuGA84mL7hBnVxRMCEqykCarh+BA582bORHpJEkmlMKmRnAHnZYvcAXoidHBcRG15xrhFH1CY5VZKt6zxuNnF0DeKIkgiNorgqLwdl+ASFz6YjOR4K8/FsAYu8SmKBXumSHrINCfgwZwyrJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736847456; c=relaxed/simple;
	bh=bxSSQwDA4tkUQvp2I97QdvBvpAZv/bPt3cwtmur404s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZkbO3g0g9NmnqOl5KeAQW1kmFuhX6Elai7+KkK/djNyOM5CixSkeqmqetNLSAHVQaYEbIhu2JWYCGCT8o71nBanHqqvE3QjvXSmJB3DS/lWJ4JUEFQ4vsEZ6D9J9j1P+c8v3ym6rQUzLjaeQQVWUhq637tLF7FLze+AVSCPnrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EOCzLr5B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EOCzLr5B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736847453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4unegCf1Wu0YCpS63WtY/VfzJKeqoFkiV5mkzWfDj/Q=;
	b=EOCzLr5B9XHuwNYjdi78ryHAY2TWjILL2eFt8ZwouOPiuyGEaZp0c/N0q18NEmNZkKar8c
	ZgLTogJtVqwrxWMFzgR+uksJ3/yFM2d4g+kqzan2YtXhLvF/YhR6T65b6MHu3jQap8DxM4
	W1jGt7NKK31q8BFN22MEkaW3JJoj3ug=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-0ToT3eRGPcWdxvOaIRHxzA-1; Tue, 14 Jan 2025 04:37:29 -0500
X-MC-Unique: 0ToT3eRGPcWdxvOaIRHxzA-1
X-Mimecast-MFC-AGG-ID: 0ToT3eRGPcWdxvOaIRHxzA
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-385d52591d6so2292584f8f.1
        for <linux-s390@vger.kernel.org>; Tue, 14 Jan 2025 01:37:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736847448; x=1737452248;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4unegCf1Wu0YCpS63WtY/VfzJKeqoFkiV5mkzWfDj/Q=;
        b=HEXySQcj5LwM3jJHVQlQPfocWWEho2OmE36+OyPEZdEjQCQU/uZKhBpETsqwRWc8Y2
         G/ITdSQaoioLMXHPVT14CIkFkh7Zy7LpcNNTjuHUoCiMntQ7VdH15+dRkKlvvPK6+eYw
         osO4K+jv6NoIT2cDgwgUir1DuMA9cy2G34W8SLlmVent3smvdweSX5ccKJqLaiNYf1Dj
         SMCa4thV5vIMbRzGLJKQX6xVWCSStaHAjAJoIJDqv1h+/nuvIpHGhzWmLAVZ4lRXlxaI
         zJUrD0GqgLEevfO4ZiVWqpa3knYSVeGVNT9uDFUGCcWA6IWSkHpg4VDXKvRyzx5V/OWH
         fEOg==
X-Forwarded-Encrypted: i=1; AJvYcCXdwDqB6YomEyOuBd1BE7nHyHXQPi1EZRFo3/ehzGebIZdWf/En8ptOklISBHCNFaCb6PQXJLJCQfAh@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzx2syy1ojvd7lAc/TiWvoiOSTI5oQ2gejvcd5AxJG44RKXfiP
	W+bs9PFrUGOAQDCAqnEv4l2EHSDLbHdfGbwNqBWudgQix+5tvoXivpu3c18hOBY0ewKhKELOhYL
	Gan2oxcMPeO6gVwYNOmmK8I/kkpgmmhnvsr2sAqNtDMkAgZOv3bZ0oRjUGEA=
X-Gm-Gg: ASbGncurUNYJbfKMNgFlOgcPON+m/tKT4tiERUWBn9pyy0DvJxBcN4U5Wogbnwa0qIt
	c4yx4VGeQCvgurkppOWbfsbcU9OrlgM5CEBWI35aP+8Bon9SvAbZXpe/+6HP207kjg+6j2wO7Bi
	vvyvwyzhkRKw/6R1SmOKUtLTUX/ZkaZHkq+h6KL9LEGuPHPEZXUUYZpJVRzlmR1NpOugWpE6YPx
	VVNoeRAGzojranJ/rQTIHdNVDVNY63XHiixGBQDPXl5/Y/5xPI8ICoXGloQ1YXkKbqJTKoUVtHy
	l4CZoqYe7hkmUOgqiAAQ488/j1YLdfpTdhw5gTT7evQLgr26iE0EhCJI1T/XmRuJ1nYEQf3fjrT
	PK2ViyzNy
X-Received: by 2002:a5d:588e:0:b0:386:4332:cc99 with SMTP id ffacd0b85a97d-38a8b0d61c6mr18692622f8f.17.1736847448441;
        Tue, 14 Jan 2025 01:37:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1R7B7r1cnpdi1vg+SF7dPfwDe3mdJkF7aesF1fW15UEOU9zYrHVCeaEO1rBg7o+/IJOcWZw==
X-Received: by 2002:a5d:588e:0:b0:386:4332:cc99 with SMTP id ffacd0b85a97d-38a8b0d61c6mr18692602f8f.17.1736847448055;
        Tue, 14 Jan 2025 01:37:28 -0800 (PST)
Received: from ?IPV6:2003:cb:c738:3100:8133:26cf:7877:94aa? (p200300cbc7383100813326cf787794aa.dip0.t-ipconnect.de. [2003:cb:c738:3100:8133:26cf:7877:94aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc0bb7sm201505755e9.16.2025.01.14.01.37.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 01:37:26 -0800 (PST)
Message-ID: <6e42d4d1-2673-4a89-aebf-5b15ac9bde2f@redhat.com>
Date: Tue, 14 Jan 2025 10:37:25 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] KVM: s390: vsie: vsie page handling fixes + rework
To: Christoph Schlameuss <schlameuss@linux.ibm.com>,
 linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <20250107154344.1003072-1-david@redhat.com>
 <D71OMSL3ICG0.2AXYO3UR6MS50@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <D71OMSL3ICG0.2AXYO3UR6MS50@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.01.25 10:18, Christoph Schlameuss wrote:
> On Tue Jan 7, 2025 at 4:43 PM CET, David Hildenbrand wrote:
>> We want to get rid of page->index, so let's make vsie code stop using it
>> for the vsie page.
>>
>> While at it, also remove the usage of page refcount, so we can stop messing
>> with "struct page" completely.
>>
>> ... of course, looking at this code after quite some years, I found some
>> corner cases that should be fixed.
>>
>> Briefly sanity tested with kvm-unit-tests running inside a KVM VM, and
>> nothing blew up.
> 
> Reviewed and tested the whole series.

Thanks a bunch!

-- 
Cheers,

David / dhildenb

