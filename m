Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEB715539A
	for <linux-s390@vger.kernel.org>; Fri,  8 May 2026 01:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778202047; cv=none; b=tn9KqfejX5mmShfNDaTIfGghpnYYRgKp2ZxXdoDcNxwv3lnlxwl7ZDefau6meCycf2mjFUDRb9xcgsoHyG0Qk/xqBletWqJnzUM+LrFtZrE9pKAiyATWNxNGRtrNBUJ6cHSDxcww/W5qyqNzG1LlnrnEolRJe3HAr8MOK+glFFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778202047; c=relaxed/simple;
	bh=+f3TYFEw6exzJmL9WG2dY5SC17IkCQ50QjEAg3n8jFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZR4CxNoHrW48n1S/D7yhV6k+JEp5E7OSwQnY+3uQPS6yr2QsZgKtBpci3htmg+mRVqFkDRSsVKaWKP2yho69WC1m6vhQbaJw9Cf/QVF7s2QeXmc53cbAir0bUyYGiAT1yCbu5aosX9lfov/5gLoY9mdcYawPJrSAg7+ZCGsfzXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rss4kri0; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rss4kri0"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bc1f0830f44so484987466b.0
        for <linux-s390@vger.kernel.org>; Thu, 07 May 2026 18:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778202044; x=1778806844; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfGLfBB9pvzUSSavaG5vNtkZXqVqIkKXeFYpP5mMAEQ=;
        b=rss4kri0t4tFOojrJtAH+V6SZaCevbQa/zv006AeNAzgmwMvio1Nl4ovzzVr5pri3h
         9OPo3T+RA1KPIRN7VE7SahDFSu7jWC2qE1O3qe7DOXsgCkjU8AvwH3tw8zW5bF3Fwb0A
         y66hFxhlJkt9oJozhc2cQM5k2YibtphEShZ8V4TzjDuCkTISzT+PJfdU5sshCo0p98CL
         o617kOK+1/GqwAj9dNBcPpCAxiT5v8xC+qgPm2+1J9Fyo/cfXVzgS98/c+viLrLVxA0D
         9tDbnJMKCAc5KvZHiWFJeR/DvAPVdJQTfGFRLq/vpJ+CO/vnQYISP5cDuYykQFNhs16c
         KmmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778202044; x=1778806844;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfGLfBB9pvzUSSavaG5vNtkZXqVqIkKXeFYpP5mMAEQ=;
        b=P06YPLKO3mjPOYKkdmEWSS3i0c/6iuDduR3oasUAgp8AztgFfnpB6Z6RGsohQfok70
         TfhTsd9O9igcXxyTzSMgsZbQN6uihqwsl9sHikTp9XiPBHzTKmbYDBOPyoGv0A+Y2x4H
         4qDlBU8cEmPSuagigHu2Ah9tLPAr2lU/XrkNQ9T0wAEVW4Six194TgzqcBkdbOixqjrF
         VU/Ng5DR+k/WIKrFaEIhfuYdIlheGn3kEFXrl76hLgTvZ4Pj9xLKvtiYygTmIwovn3nS
         AXo4xx+cezSSAVeVBUkSYOwNDqZV3TSq5fQYYCJ+n0YYoPpsrOX9Cx7x3I1RuPMcdnf3
         Rh1Q==
X-Forwarded-Encrypted: i=1; AFNElJ8lu11v+hd7rc4khc2MQh/Qnq6rPCQBvLDnTfU/QSWIkCvEACG8k/WcYmgtBN7FaqaTA6Ns1Z3Vh92x@vger.kernel.org
X-Gm-Message-State: AOJu0YzZSS130gJyDHsfTqge/GteTbWiaGNhbBjfB3ntLNEy5BzsIz/n
	a5J2cwuuY3M3NtDYWpbF4/GbYStRBqueUI2bFd1JCYBYe2k8xvoH5XSl
X-Gm-Gg: AeBDietrLKb6qO/WmAYxXSuWcdSsKcvEs2i7dCqXmvy21VTKxF3J1dZKoSvwFg3cEyE
	thr3MlqlzawjLXF3HYRSBrv3qx3m64qA5bWBBxWQQWpz+3FLx91ZK+H6eL9hVAOguVd0pvjKbup
	tqp1Xnao/dpmHZTPrs8btp1MPZvTtG7HhAEOXcT4n6dhGpTIcfqXffN3iWzgIFa2DvowjKLPWBV
	ErJJdB+0Rvc2jJG4fPfbAwK95Pp4i/GyuQSli4aEbt4WJfJkdwRugfyCqP53ZDanLoYy24mv6LP
	GdVsfrbwxv5COuvfeULTEpyTJknoM5N7jq/BcFuWsH2JNast0rhnSUSwsDbaY1DjSGDN+zOo6sk
	tyJeo7KzMjEt+9gyKlQXD2c8s3tAmSKPDEMNuHcHplVAoTw2NUZbT16j9yTYY5O22/I5QOv2kfM
	XBw5/bP3njSEjuFn1bfuoZpWH+pDp6Uq+a
X-Received: by 2002:a17:906:ef01:b0:bc3:99d5:a29f with SMTP id a640c23a62f3a-bc84cc72ec3mr272203466b.5.1778202043620;
        Thu, 07 May 2026 18:00:43 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0dfd334sm53826a12.16.2026.05.07.18.00.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 May 2026 18:00:42 -0700 (PDT)
Date: Fri, 8 May 2026 01:00:40 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Wei Yang <richard.weiyang@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Oscar Salvador <osalvador@suse.de>, linux-s390@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v2] mm/page_vma_mapped_walk: Use ptep_get_lockless() for
 lockless access
Message-ID: <20260508010040.o7bypjnfceeqloeq@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260504130434.2285053-1-agordeev@linux.ibm.com>
 <20260507093433.q5xybwumryxclnqy@master>
 <43815634-29d3-4fa4-b967-0e251ff32f73-agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43815634-29d3-4fa4-b967-0e251ff32f73-agordeev@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, May 07, 2026 at 12:32:09PM +0200, Alexander Gordeev wrote:
>On Thu, May 07, 2026 at 09:34:33AM +0000, Wei Yang wrote:
>> >@@ -310,7 +310,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>> > 				goto restart;
>> > 			}
>> > 			pvmw->pte++;
>> >-		} while (pte_none(ptep_get(pvmw->pte)));
>> >+		} while (pte_none(ptep_get_lockless(pvmw->pte)));
>> 
>> As Oscar mentioned in lkml.org/lkml/2026/4/27/630, map_pte() may take the
>> lock. So probably it is not right?
>
>If I read the code correctly map_pte() might take the lock, but also
>might not take it. If it took the lock and uses ptep_get_lockless(),
>then it is fine. But if it did not take the lock and uses ptep_get(),
>then it is an issue.
>

So the rule here is:

  * ptep_get_lockless() could be used for locked and not locked
  * ptep_get() only used when locked

Right?

>> > 
>> > 		if (!pvmw->ptl) {
>> > 			spin_lock(ptl);
>> >-- 
>> >2.51.0
>> >
>> 
>> -- 
>> Wei Yang
>
>Thanks!

-- 
Wei Yang
Help you, Help me
