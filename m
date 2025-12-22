Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4A317BEBF
	for <linux-s390@vger.kernel.org>; Mon, 22 Dec 2025 03:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766373526; cv=none; b=szvpVxE2ERMg39pWptJQJafVVKJ1crSqoc5CfR9wyKAqiGutvSpLpCvWTtxoasjFECH0cBH0sCdN4IbyAD52DY20Yuc50SLVbD+sQrH5w3i3plRtzqS1KNY2GzkUEDYV43oOceX1eN0OdEXdwfglOPqXXDi6xyg3ICa569djXgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766373526; c=relaxed/simple;
	bh=f41VD1SP11Rv9FnrEl5Xez8441f6aADR+N98KLfz3Pk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=Z/O1KG8n80y4Lg6kIcqLHDZQBbLUYeqbU9tT7qUjDbCXBCl/dcWepQjbbLPTBUtj7zXUXfF7M/RqjYIknGgfvkYyf7pMow5Eh8UHkgA575hN1sWNL4PGq17gw7YzDBelX+OQmk0Lo+1hkYOd1qVYRuhxMjW/16AMRD23+a+TnPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CCfHUvyY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCfHUvyY"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a2ea96930cso38408105ad.2
        for <linux-s390@vger.kernel.org>; Sun, 21 Dec 2025 19:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766373525; x=1766978325; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dSEX9YgmDGq6W//WwbZ+YmPko80Tijktgs830EHMcng=;
        b=CCfHUvyYUNHs3ZRxRMaE4chPYppybGI9FZJHOC2J3JYGYVME/1CvTBCNmO8sHexdxy
         DqJaDsZ8F91ifZSIPCYBda+qP84rZXgiNlEKAwFf6dPvzt+P9vj6oQIg3BZ0GXIwa8i8
         4u8iqc4ncruCqdPZZs/i4Q9a+UCqbEkIP3Pw1wrjp7rNH2hB3PaUqOvvha1p/epyb20O
         ke454P09R0yTfmmAfdEXyXRoENTMZqtxo2W/yxhpoHI1hODClQc9zS/HUDipwc8ncoRS
         S/m83H0AEBfIpQf+PwQSHSyWRCcuJBjEsMRAvFHy5eB/wBRBEHTQH65wyr37N5HW0UYJ
         tVlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766373525; x=1766978325;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSEX9YgmDGq6W//WwbZ+YmPko80Tijktgs830EHMcng=;
        b=iRn7LSpRXWUOvoMVIaPxz/MAQNvONkTaHHbkuJTnOigMBsQ9ybU9s+NlN/pWH5vDe/
         Hme1+vvNN3aJxvMLROiqY3NfiD3xPUCvnOqeehi8mzJZRR1IRJHFJdn+1OJaoY0GCBPC
         SwN8SnDV0Sc70zJgEKasNTBSASltwb4+qkhGHYiWyy0mvHl4BpnBEOTpjVXoI8poUa/s
         330Bod8fEedSBv2DC7208J6uhrgtE+uYUrcada1ZKpbFD4iezSPxPGDsea97ZkWXetQC
         omYDuaxuRw9QEWNl2jNAdK59bfRLlntrqUHiwqtxMyyhWLlmzLe0jUU2NTMRD8OBA/El
         T1TA==
X-Forwarded-Encrypted: i=1; AJvYcCWqSDiptTXbSC3NKTOw9k6nESIje22lsgohPcI+U4SnTZSxEkl3RFx6cl0lI+mNcDe3ioydg4j3VkN6@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj8LyGsQjageUnOvmD8Ue34MZgJNhyfNr0RM2Z42e+UEfNsOav
	wWsB0mcR4osXKkklwq1VfmDEwYlStazSfysyAaK8QLUS+WigSMK+vo/L
X-Gm-Gg: AY/fxX5PbTtzsjx9fSWWKT+MoRt0HduF1xl9gxk9wLlzAFdDlEfV23dZqRLFdzGCSBA
	vShRPrRe+Uv2OhhFpJpAZvWRxknsRpVEAV+4XGAgwn2g5hrgcL9HkV0tf0E+n117XQryI7cKEXi
	Rzl2GclL8Og+/HhofSqfyMJAKW6qnYSpDmCWkEVgr7Zu6Vq714vGyceucx2OviIJgqT9OAcEkWh
	qHewMEQSiOaYm9neBpnT9YZV2nSguZrHY5z/jAQj8vd83ktEgeu8SD7u/3xAHv8xtZSYO9vLzb3
	nh/f5trgyX01QfON631aa8KmXby7tzFU24sYX6gtm770nOdl6wDXLMccv2bQkMu+3fG2+tfK8Xd
	7ALtc2ZZr7EQdG9fDDbIvs7G5ap9lenigeqPRIcRQfce181TDw9lz4hxsAYxhBulOTrMCDi/2it
	ASXK4=
X-Google-Smtp-Source: AGHT+IE25cnCTvyNKTbDCfkrMSOXNApuJseJLU6aD26Xlbt6oCT43145DxEBaionq8+6wAvphhVpBg==
X-Received: by 2002:a17:902:d488:b0:29f:2b8a:d3d with SMTP id d9443c01a7336-2a2f2202ccamr90870945ad.4.1766373524799;
        Sun, 21 Dec 2025 19:18:44 -0800 (PST)
Received: from dw-tp ([171.76.84.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d5d863sm79699845ad.80.2025.12.21.19.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Dec 2025 19:18:44 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, Sourabh Jain <sourabhjain@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>, Christophe Leroy <christophe.leroy@csgroup.eu>, Heiko Carstens <hca@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, x86@kernel.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] mm/hugetlb: ignore hugepage kernel args if hugepages are unsupported
In-Reply-To: <655cc605-2ce1-4ccb-8cc0-a0a31a9c89fd@kernel.org>
Date: Mon, 22 Dec 2025 08:42:25 +0530
Message-ID: <87fr93ky5i.ritesh.list@gmail.com>
References: <20251221053611.441251-1-sourabhjain@linux.ibm.com> <87a4zcml36.ritesh.list@gmail.com> <655cc605-2ce1-4ccb-8cc0-a0a31a9c89fd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

"David Hildenbrand (Red Hat)" <david@kernel.org> writes:

>> Coming back to the fixes tag. I did mention a bit of a history [2] of
>> whatever I could find while reviewing this patch. I am not sure whether
>> you have looked into the links shared in that email or not. Here [2]:
>> 
>> [2]: https://lore.kernel.org/linuxppc-dev/875xa3ksz9.ritesh.list@gmail.com/
>> 
>> Where I am coming from is.. The current patch is acutally a partial
>> revert of the patch mentioned in the fixes tag. That means if this patch
>> gets applied to the older stable kernels, it would end up bringing the
>> same problem back, which the "Fixes" tagged patch is fixing in the 1st
>> place, isnt' it? See this discussion [3]...
>> 
>> [3]: https://lore.kernel.org/all/b1f04f9f-fa46-c2a0-7693-4a0679d2a1ee@oracle.com/T/#m0eee87b458d93559426b8b0e78dc6ebcd26ad3ae
>> 
>> ... So, IMO - the right fixes tag, if we have to add, it should be the
>> patch which moved the hpage_shift initialization to happen early i.e. in
>> mmu_early_init_devtree. That would be this patch [4]:
>> 
>> [4]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2354ad252b66695be02f4acd18e37bf6264f0464
>> 
>> Now, it's not really that the patch [4] had any issue as such. But it
>> seems like, that the current fix can only be applied after patch [4] is
>> taken.
>> 
>> Do we agree?
> I think we should document all that in the cover letter, an describe 
> that this partial revert is only possible after [4],

Yes, I agree. Let's add the above details in the commit msg.

> and that that must 
> be considered when attempting any kind of stable backports.

Sure. I would prefer if we change the Fixes tag to the one which I
pointed in above [4] (with explaination in the commit msg). However I am
still ok if we would like to retain the existing fixes tag and show [4]
as a dependency.


-ritesh
