Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0830D29C346
	for <linux-s390@vger.kernel.org>; Thu,  3 Jul 2025 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751529552; cv=none; b=X/bMlXEZiawA+X3WLnnxg6m1N3fLlMl/tbbLGa+bHWjp5QtsEMzBrBcsByWn5/K6fUUMTU0Q6Z5343P+mCauttrEBZhsx89MAApN5EO+8rDHDs6y7OOe4DwhN+EP79gJDqe581Mq+i607nHv6E6AssflcMQuuEjCfrTQ8qhxlqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751529552; c=relaxed/simple;
	bh=DFhsksleZELpBYX9Wg732XNn3fZCMbEoBRkbYvWFECs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=km2WH0E6ZrXY40gdryosusRGf20B1It3K3kscdqrZUPLTlWGTz/JvmJQ02WqV3p2ClSWICCtXjACf8iWBzkF2svQ55xo8M/dDmteXN3n3zav52HzhIMFrNSdn/khOUsZ9CKJWBgtC6f0OEgPd5E2THHSjRBcWG7iqyopWioC3YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFfRSf7W; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFfRSf7W"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b20fcbaf3aso261114f8f.0
        for <linux-s390@vger.kernel.org>; Thu, 03 Jul 2025 00:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751529549; x=1752134349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7nTatEuPQJPZOqO3DolrOHt+0WgfQqAgk2itWSVCOc=;
        b=bFfRSf7WSbbHfCHGUK6M6PLOyob/8hg/UNs2XJA6MFD7Ec02L+mVoWD8PqZPyw9dPR
         sydalsl1wsjpidxar9ZGQKdc/83aBoJvwxDnwnAKU9CvNZbAd/Gr8qD7GwH0u9Ui/sTD
         yIEdvRgDXZtaXIPVXavmcb2x/28moixvIooDp2KqgULsUkBTfOAOwbHO6geXPrkWwCbz
         s1Q57KZ3N9fsfIhGQm6WXEl0cZnVRxBFxje5/yOLnuTGvjA0GjJPY23kXoO413DBxkg2
         gnuPU+A8noJuUoxIM8Y5Ormhemq1nk9RbJb/DcBF18BFdcrlxmNQ5/T6ev49Sx93aHO2
         OKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751529549; x=1752134349;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7nTatEuPQJPZOqO3DolrOHt+0WgfQqAgk2itWSVCOc=;
        b=slEHbtnY1DBAVw1D8+TgkwY9nPmvVTWyHDd4kx2Vvwffj2DeO4c/Nk/J5W0InoT6kg
         rSlemNkHfNtrZeOgZ5iPzlyumzWfzD/USCXCIJ0ba5HqIpv70iZY8LT0pbHGOpU2n+zs
         PykoZTaDnaM1kbU3GTNLH5mDvZpZCN6BRffX80K6jS+yCA20MZxiyTj9Y4mQkBBQvKu8
         7LYVeFgXF0VNhPziBpWQnvd40ej+PIpViAhcQNwT65H/lnSegaQFUEkXw4ibNOchoTjP
         uXp0+lBLtZKDyut44ZtMsSybwpe0ytLvnShi1jC0ajCQIhAxO7ErXeGtpCSISC32ctTg
         zQgw==
X-Forwarded-Encrypted: i=1; AJvYcCWIwyl/OUTrgnjviQ3bJEmd2x3/JuTVGetJ7Kkfll9YGMQspTA24rAnwY3ilOkbYz2tUD2UTTaCVVjg@vger.kernel.org
X-Gm-Message-State: AOJu0YxqP7Mcs+PO5m3WF/SBd8ZnSW2hVkb+/LlkNhEGwxxBOfMyb1V6
	C4zc+27ddZjR1phvS43ZGTc6HKmfeJXch+NI0OuxfemNKX9cDLt/m1JJHH0cEaqJ+s3x
X-Gm-Gg: ASbGncueB29tYdfFkxvo6IQUts65LRu0zenmZwSy28+zVvv1uNkJPyfeeitZv0zYT74
	eoD5wuYTeLkxDxKW3QIus+mo7L5K5PBlp0nxUQosZSSIEmZUYkanaUHmiwOl7xo4QjxkR1x5L4E
	aPjm96qSGhQGDGORiDfSprwHUALTpxpTVBlEi8doAamiem2eygNUaKUgKH/bBZb+8wC2uFZN54E
	QGZrux0UOM6JuU47e52ITkew8h2BLwY01rpgumyjG/B32lkvJ/uZpzx2BreYrYhQbXqPrhB5Dnd
	AyiTpC/wqYdhmx0ab9naJI/Hxtij5t8mE0/K4EGg/TMh71VVrk2wxwG2zgGqkBLFGP6TmoYGHZo
	ZdR+LACQfsnFxh4Bhp01YH1Ft0A==
X-Google-Smtp-Source: AGHT+IEttJlbBJ9Z/+WUuk5WL3MDjNbJ2QC1WtOu67Gg0W2mAIJTNMPHTXvuxM2Brf+qufb3h5Gt0w==
X-Received: by 2002:a05:600c:4ec7:b0:43b:c825:6cde with SMTP id 5b1f17b1804b1-454ad075c14mr3691405e9.3.1751529548826;
        Thu, 03 Jul 2025 00:59:08 -0700 (PDT)
Received: from localhost (148.red-80-39-52.staticip.rima-tde.net. [80.39.52.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453a85b3d44sm49734945e9.0.2025.07.03.00.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 00:59:08 -0700 (PDT)
Message-ID: <c79ca6c5-1908-40ce-83a4-56159408cb63@gmail.com>
Date: Thu, 3 Jul 2025 09:59:07 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] s390/boot: use the full title of the manual for facility
 bits
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, S390 ML <linux-s390@vger.kernel.org>
References: <20250616163248.77951-1-xose.vazquez@gmail.com>
 <aFKmUxi7d33rCvsQ@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Language: en-US, en-GB, es-ES
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
In-Reply-To: <aFKmUxi7d33rCvsQ@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/18/25 1:43 PM, Alexander Gordeev wrote:

> On Mon, Jun 16, 2025 at 06:32:47PM +0200, Xose Vazquez Perez wrote:
>> Also indicate the name of the section where they are listed, because it has a
>> length of 2124 pages:
>> z/Architecture Principles of Operation - Facility Indications
>>
>> The current version is: Fourteenth Edition (May, 2022) SA22-7832-13
>>
>> Cc: Heiko Carstens <hca@linux.ibm.com> (maintainer:S390 ARCHITECTURE,commit_signer:3/4=75%,authored:2/4=50%,added_lines:8/14=57%,removed_lines:41/47=87%)
>> Cc: Vasily Gorbik <gor@linux.ibm.com> (maintainer:S390 ARCHITECTURE,commit_signer:1/4=25%,authored:1/4=25%,added_lines:5/14=36%,removed_lines:5/47=11%)
>> Cc: Alexander Gordeev <agordeev@linux.ibm.com> (maintainer:S390 ARCHITECTURE,commit_signer:1/4=25%)
>> Cc: Christian Borntraeger <borntraeger@linux.ibm.com> (reviewer:S390 ARCHITECTURE)
>> Cc: Sven Schnelle <svens@linux.ibm.com> (reviewer:S390 ARCHITECTURE,commit_signer:2/4=50%)
>> Cc: S390 ML <linux-s390@vger.kernel.org> (open list:S390 ARCHITECTURE)
>> Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>
>> ---
>>   arch/s390/boot/als.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reformatted the commit message and applied.

For the record, there is a new version of the manual:
Fifteenth Edition (April, 2025) SA22-7832-14
https://www.ibm.com/docs/en/module_1678991624569/pdf/SA22-7832-14.pdf
