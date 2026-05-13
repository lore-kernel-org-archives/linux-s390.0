Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58903379C2F
	for <linux-s390@vger.kernel.org>; Wed, 13 May 2026 06:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778654839; cv=none; b=R3DscTQM6lWZZyg2GC9+6ovwS6GAbbXna8lbn+pylJuSLKe6P8uuv4Ee/yvyvk8FdzDUNxs3SuOKrBxKuP44jnUdIeU9kKJKbXcHXLEMBQ7u0k53+WH9IXftNtF8qyjXKQahkPjr+C56+pzg5AimxMH51LnIzS/kFezRVp5zIxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778654839; c=relaxed/simple;
	bh=2X0H0p5NSkgPnIRkuJQ0A52/WPsnDBookRtsYGCKrJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUX/P+9p1TXdwR+9Qc4Z4xOspp0fFWu33MK074yCmvacxuRjUKV0XlO+oPQLdzvn0I5EzbTCNy1W9p7lxeb1zVHokjjk2ByzmcgIBQMVYabIB3Y6MDGGiJs6E3rn2isooqb/2/41dWlDzTsSTnQXYzPaFLnXyQwnYN1VNeS/PKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Kdo4dMqw; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Kdo4dMqw"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48d146705b4so76889645e9.3
        for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 23:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778654837; x=1779259637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f2g2BIMhP1pLlqkrEASLiC7ivBcGm/mtdCu11mEtx0Q=;
        b=Kdo4dMqwJkEG0u9j6348OnBghNBRDujOgE95ByyrQIuqGaNRwRr8O4/JEp0xYSGGrr
         VEWIF6zJ1WcaKiiRskntxzF0ZAr0cy2aiBrbVZ0PDhjBQndt+ysxo+m8XBqw3ipKCPQ9
         CGV27WAM3xFv7s1gCtazO5Df49kMd4si9mNNDGxZrmjA+hFz+iYqZy7XO/e0aIUirmpq
         3gLkxzXbPfaTkXb0HpLuGb7msEsSg2j4DC0qYcH7aLyJpSHhQ78nZthVBiteBtafqh7V
         VNRz+Ht2UmbvGJW4eAJZhy5mWrhdeO74C+zd2D5YUwccvDFlhVqEJ5sx/y4jZvoQLNqi
         wdNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778654837; x=1779259637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2g2BIMhP1pLlqkrEASLiC7ivBcGm/mtdCu11mEtx0Q=;
        b=gJ8VWbaB2sH31FOY/rxmtvu/FwJDpww3ULKX03wt5X+uLyg82TgqKn7Ai6Mz6l9kAU
         0sx1hEA9S0gDAeqeDgqUIy9YJb6ZjSGrslM0UeczT0ofjoETwse/HtdC4HS7arsnJtSs
         xe/2poBuTtmrxkEBBafioDofYsdoS1GW9BD10VDe92PWMZ6Dg/5Cyl2+fwbplDfuVL9z
         biVX8V1UmYb5eaf2W7sF5c542aSdA1dhh+86svjq7oaqPtcNMoH919vt+x/ZfN8bo3Z4
         BQcDEXFU9Z7ba0TrXrAHzNx/zYmpiGUxXmYPSfCGIzT6y3OfMtQmCZbBkRZ4CHOqPLVw
         BbhA==
X-Forwarded-Encrypted: i=1; AFNElJ+b5/s3aHe6usbHWg6c4BhtSGL4YJC2mMRx88hPGLGyh7hiKsgKdEU9SQdkU4Mp2VUC1jJXjEzYYbYf@vger.kernel.org
X-Gm-Message-State: AOJu0YxTSJ7a4EpLH89R0jp7veBgAUjThH4Ift7fENiDqzF0uaDKnHKj
	JGPe1gv0OBCODkeVzaesD9qqyJH4zevqyunXwYKl8DPFA71t7o2E1UBICnSuV6Lkilw=
X-Gm-Gg: Acq92OG4XGMlae4VdOBtEKHZRkVtaizBj872ZB6BVAYtl0kKRESHfiP2+fPDzph/oez
	mUx4aFKawSgnYgMIMok9bmebv80gK5+izx0rhzoTmCDBC5PEdPm3jHYI8XbwT+KPe3cOnE3SjIz
	8S6E55HoaJ0AaoP6+U8AseGUSBEO0JoJJVlLXQLO6wB86V3zH0A5Wq8bp3dx3vJQeN9K9Wmwrf4
	CprqBzAxDeVwIzc+qEyi+QPu4cvoKFh6XQpBtVmKWfsOWUfr2S2OUuMyRX50brRIdV3rN3d1dAm
	Rx0c/zmbB11Ss/jW3j/I1zAvDuLmZboIJSdJxnY0vmMfY7m0ZxfxK1w5ctACUx55m+Y8TYzG6+t
	tfe7feVf2YgDR1GNRKk4lJu1AeTew3A/tKkBWrmrO4YQi7/uxYrUsWLkNUdBQncoZd/kK/nOHP9
	9EiAcMPIuNoyor40s84UlwEIQVC5V7+muyt1Tq
X-Received: by 2002:a05:600c:1910:b0:488:9ed3:1492 with SMTP id 5b1f17b1804b1-48fc9a09cb7mr27643115e9.10.1778654836793;
        Tue, 12 May 2026 23:47:16 -0700 (PDT)
Received: from localhost (109-81-93-105.rct.o2.cz. [109.81.93.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fce38328esm22796985e9.13.2026.05.12.23.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 23:47:16 -0700 (PDT)
Date: Wed, 13 May 2026 08:47:15 +0200
From: Michal Hocko <mhocko@suse.com>
To: "Liam R. Howlett" <liam@infradead.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	hca@linux.ibm.com, linux-s390@vger.kernel.org, brauner@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	timmurray@google.com, "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH v1 2/3] mm: process_mrelease: skip LRU movement for
 exclusive file folios
Message-ID: <agQec_L2TXtaXOEo@tiehlicka>
References: <ae_roPR64e6sY_fN@google.com>
 <afBaJLLFigkdszov@tiehlicka>
 <afFco71vwmpQy3pk@google.com>
 <afG-4hq7Hr62Uu6J@tiehlicka>
 <7f98f461-62a7-455d-a7a8-cb8928465946@kernel.org>
 <afHeXY-yeTwmURWh@tiehlicka>
 <4a612d63-2838-40f5-ab67-79bf35dd3a56@kernel.org>
 <afIZQOtaBabeHtCc@tiehlicka>
 <b2d9fe2b-abb0-49d1-8056-ac93aa232bbb@kernel.org>
 <7g5g57jbll5joujbwjb4osqhdwqd4yzc54wmoi7ftx4a4chuax@xtxyljtqaodp>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7g5g57jbll5joujbwjb4osqhdwqd4yzc54wmoi7ftx4a4chuax@xtxyljtqaodp>

On Fri 08-05-26 22:57:31, Liam R. Howlett wrote:
> We can safely drop the flag now if you want to, because everything has
> to deal with an empty vma tree anyways - a race can occur between a call
> to unmap everything and the task seg faulting.

Let's just drop it if it doesn't sever any real need anymore.
-- 
Michal Hocko
SUSE Labs
