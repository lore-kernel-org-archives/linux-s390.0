Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD46139B963
	for <linux-s390@vger.kernel.org>; Thu, 28 May 2026 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959031; cv=none; b=QTEWpRJl+BmkR3ScspMkKpUgBkPkFts6jYhpSXv3/Zgp4cUalRvar/VRJQr5oCGp1kH0+7akvSD0K76qZleozv0Q7TomoZn2riffD62/buZA0DZRSp7mr7rhgFepQ2KcCCJSrZd4fSZB/yVIZH5Qj5Og6Qyw5+mNp3aF5c75CuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959031; c=relaxed/simple;
	bh=4pNbRRNcvcxtZWMWBhlJACXXD0OEyFL5XoBQHvV2CE4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQo9gRkhfwEBcpgZRIjtU5G4WDgLnDCeB0l2TYhP0SrjkikSnDp36W0u2JJSNSrH/mJKR8zO0DB6bVJSii6I9JJ1uPA0ev+h328gABXs7RhqD56wxWLw2HeDsihADYYxI26550qUdRC1C3leHIlE9lQajLlmcP2C/g6a0KW7b98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3cZiBaI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3cZiBaI"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49041e84237so51456945e9.1
        for <linux-s390@vger.kernel.org>; Thu, 28 May 2026 02:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779959028; x=1780563828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCmyXs1jXAX32h+bsF7sjD219vXUOiP2EoLZokHkEFk=;
        b=j3cZiBaIHvPZT7xFo4KK6C8BvWfHdr94JNfDnHkPRCL13l6L2UcnQvVOstMxsKx7qq
         XinJ1qH11ME1c0YP81rEwUZwNjyY+EC/AEJ/U0/ZrCTZmlqZEjs67ztTzNF7AudrqXow
         jsw+DAuTQmKpetZUXmuh/tCRlKuLckYtAJk3pesxdM2G86JRImw+db6zPseEpvoDCcoE
         2+K/avvwojSaJeMU1kMLPpDIFM9vEUoa7B1Yt0kvM13+DckVtg/1GZSz3DaZt5J36ibf
         WXYp8+Rc8G2zitw8laOtatRqAHIMAxU06Fsv92JYQjXoMlT5+t23XSUabWlTMJI0i1Ab
         XodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779959028; x=1780563828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QCmyXs1jXAX32h+bsF7sjD219vXUOiP2EoLZokHkEFk=;
        b=LrS7S+iAdPTsrIldIrptygrS/0tyUa0mWTGtn90ORA4G1SW6h4wFN7ub2uSzGonDg0
         f1Makv1L1P8N6F+lvCYiMX+q/zeowSJDr/mKo85GiNA6pnGmncip/FhLlTF1I74eSRtF
         3Zt9ep4utDPjyFFUVW3VrlcMedcuCM33MZHVJS0yqHodeXfKI6GoZ+ktQiuxfvyObSIO
         i2aV91NgXVx9ScLr2xPGRoqg554MmjwSlYPS1fxab1SDgDv0Ee/6ru0a2TQ/0R7MxkEM
         iwG//sodhTjs3ku8X+OvjW/mUmUFakvryXNUH+TJ6l0BNxT0TFaxhyUd6NG41h/Dcovj
         ZrDQ==
X-Forwarded-Encrypted: i=1; AFNElJ/bEIOhPbZI7560wi5Y+fjx3dzDcwQE9wN7kEg0GQ1Zl7t3RDd9fLpHQ4fhwdCHenx4L+c/a7J0bmr3@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ6bXB/XZ7w57z/u4OlYzzhyGx22rwnIs0FQLSBGPOWjsU9JnE
	ua/3kON4RrUV8Q3nJFuGRJOujhBK/x7QMfTZakGcJR3frwRE2LPgik2g
X-Gm-Gg: Acq92OEMEb9NGGb54H7D1ZjDWuSgEb6X2Ktfs6o8biUCuz6Qni6mg0y9v3XOskVkP4J
	ize73VS5s12yeeuOjAypMdEPLqL5Qs9LPOAwS3RDNvfhGPDNgrzF3Uwm0lzv9EBOYF/oIMST+eR
	Al6DulSxU/+NMKh9gvt09UP1sF2Me+uXWPO7NL+LjiDF7s7clxlfgIV4u6V08AQBbWxP1wTtVnz
	AUMcHclQTLyAX1IjevuAuCissJHBdVUOpitTTTKyRPnpZvnKW51qTkcITAe5kpMt+R4T4GRzgAF
	3UlglvM2/CREV2xOEPpAE0W8sF/+vS+jZfzGzUlWJvbY2SSAHEXgrPQuiqh+AgS04ZsWqLF7tne
	iCIwVcfoVRSSPeNQpiqAFALpLUJAqHPTmFPJW1+IIiUaiA2clr+aRw0ZaLuckDImvWyHVGjxxkk
	3g7f46pvGW8vmjvDF+UgjCS2Jha4lDptKSIvnv8k+NNCndxpZrY1QnBmkvQobmL4D2190UF+M=
X-Received: by 2002:a05:600c:4f14:b0:490:7df7:9190 with SMTP id 5b1f17b1804b1-490947a780cmr13101365e9.8.1779959027834;
        Thu, 28 May 2026 02:03:47 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eeb36c40asm1504601f8f.13.2026.05.28.02.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 02:03:47 -0700 (PDT)
Date: Thu, 28 May 2026 10:03:46 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Yang Shi <yang@os.amperecomputing.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Juergen Christ <jchrist@linux.ibm.com>,
 "Christoph Lameter (Ampere)" <cl@gentwo.org>, Peter Zijlstra
 <peterz@infradead.org>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 0/9] s390: Improve this_cpu operations
Message-ID: <20260528100346.1e790a53@pumpkin>
In-Reply-To: <cfdb20a6-5621-417b-9202-d788ca34251b@os.amperecomputing.com>
References: <20260520092243.264847-1-hca@linux.ibm.com>
	<9d503c6f-5641-4b28-998e-01e38b3622a9@os.amperecomputing.com>
	<20260520233409.0683f595@pumpkin>
	<d8e61923-2e0b-422c-b2f6-5ccedf3852bb@os.amperecomputing.com>
	<20260521103742.9603C8c-hca@linux.ibm.com>
	<5158d4e8-19a7-4f60-b2fd-bc6bab22baf0@os.amperecomputing.com>
	<20260522091805.18098A5c-hca@linux.ibm.com>
	<cfdb20a6-5621-417b-9202-d788ca34251b@os.amperecomputing.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 16:44:31 -0700
Yang Shi <yang@os.amperecomputing.com> wrote:

> On 5/22/26 2:18 AM, Heiko Carstens wrote:
...
> > It is amazing to see the performance improvements you see on arm64, however
> > I believe that is mainly because of the large amount of code which is
> > generated by the arm64 implementations of the preempt primitives
> > __preempt_count_add() and __preempt_count_dec_and_test().  
> 
> Yes, we need 4 instructions on ARM64 for disabling/enabling preempt (one 
> instruction is used to load current pointer, the other 3 instructions 
> are used to RMW preempt_count). So I can remove 8 instructions in total 
> for a single this_cpu ops. That's a lot. Given this_cpu ops are heavily 
> used in kernel, we end up running fewer instructions and having better 
> icache hit rate, the better icache hit rate also helps reduce cross node 
> traffic for 2-socket system.

Is 'current' kept in a cpu hardware register?
With the process switch code updating current->per_cpu_data.

That might mean that you can access per-cpu data without disabling
preemption (for single ops) using the same technique as s390.
So something like:
	mov %ra, current
	movb per_cpu_reg(%ra), $b
	mov %rb, per_cpu_data(%ra)
	// per-cpu access using %rb, process switch code will update %rb
	movb per_cpu_reg(%ra), $255

An add will need to use a cmpxchg loop.
For simplicity use a fixed register for %rb.

-- David
