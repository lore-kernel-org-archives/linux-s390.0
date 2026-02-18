Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EB034253D
	for <linux-s390@vger.kernel.org>; Wed, 18 Feb 2026 15:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771429955; cv=pass; b=pIxmaYK7FDvs/q1FpmHYO2k1E3cJs6d6rE65UKamOG3K8hkMvJw4o+W1RBhQd0qmJ7fP6TVtCfAn4/Jw9cEJN65go7WKt9votdGLSNhogaU6Neo90WSmy1Eu0nme+BRovArvcJLax3aSVt7f4E8Yl82lsGPmECyQCRhxzKbuZL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771429955; c=relaxed/simple;
	bh=K/8JkWJqRGjG1Au+HIiW6y70F8UXIF6b3iEb+LfAizM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fsehNRozU5ISFZImVvXfhWH8FKWlfvTxjoMaBlkOvg6DFScwEEWaG7MkJlyx2H2uPqkmF7/sz3aKZLSR4M7s1WOTbZDgIjJkNBDT3yt74dWcD5z946zp6zkxkxU/MAtSx3TWRkN1gUSvpz9zKAlDY4J9zB2AkHA+wAPJ47cynp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pJYreQvG; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pJYreQvG"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5069a785ed2so554671cf.1
        for <linux-s390@vger.kernel.org>; Wed, 18 Feb 2026 07:52:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771429953; cv=none;
        d=google.com; s=arc-20240605;
        b=XyV009326u1bI9GXPN9Z+1uIhetU2wLgArJUlg1h3+MMixFkHsVMKMbDwGOBUFuk9D
         7bf3X86jzrppf+7puzZdoy0bRUfwS3p5x7OxoY3UN/4M05LDpRnO/8FHjmYluvW/kS+a
         ZAyHVVN2i4+vLbypRhTUNWlKfGaoAxJGmwsTe1Z4YEKaVlhxq9AhmrMBomXSr3uX9f2f
         8MFcyoZ+KooYuDdOKDheEnENhU3zdXx08kpA2Kyaa5co+nP3l+xWfa9Rjjg1Q4IlET+g
         eFjZ6YrXGEVgsKFDBZNEpuK9btdIVAqYuCXW42MeMcnG8Tm/YC0M4DU6GznANZ2jIijc
         O3Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K/8JkWJqRGjG1Au+HIiW6y70F8UXIF6b3iEb+LfAizM=;
        fh=nfroZ2B+hv85puZgb/IYE5aQ0b8Ez3S2q3JxqTW+PJM=;
        b=IlapOiiJ94k7caxdrd+NV8RpEhVUy+LLSn2bjoEFv9/StSdAAY69vw5J2gXZG84aPj
         YFscpcgdhcWOQ0g05mTuF8VWmo7wSha4wUsLg7YiN6g+uvaFTSDAqVHSzMyThBca8StN
         +Ec7eElsPC25PAx+2Jn5pVPHzqN1FULZ7fqUjTyZwqgPTkM2DSvsg0bKOD5OdJeD+FPy
         CUbV+lNh8u+W+qo9T2sUAuLubBd5DvHLKiyg5FFs9k16dTUvpsAcZ5/Q6rEGcyzbA2ah
         HV+wNosbyNkPtesVgKysCQn/kRj72w6awJuHOkTK9eTjnitqzIOvFwiwUlzW0nFjocET
         YZFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771429953; x=1772034753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/8JkWJqRGjG1Au+HIiW6y70F8UXIF6b3iEb+LfAizM=;
        b=pJYreQvGc11f+23nG817BPXzvEIbCxPXmlHrQL+Q7iDJSZrmuD1EQr54Bf7/eNFHIV
         TCFdDo+YKkVlb6FIEixx91j/yNWCu8upI3ZPUnyeg9xOyoL0rqnK5KuLOzvtZTVI9aFj
         /HUCl0r08w9OFhSX1dtMMziMtrsD9z8BP6/JeWaRzDtL/ibJphnofQWY1s6f1WQhBqum
         xxhkWczX4jl+DcXoAefa+x+M53tsbjlVdOJFPukRtZcgwWivhTcc4KqfhwuNsG4sTXDW
         8+y6rmrGia0dypTOhfDEx1OAvAqqWlNKJuX59cx5FjHHwQcKpQu74nVTwtCh/dJIXhkn
         fx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771429953; x=1772034753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K/8JkWJqRGjG1Au+HIiW6y70F8UXIF6b3iEb+LfAizM=;
        b=R2vFRH9t7NuLXQhpEEm0/a2S04wjI7JNZ/9aLhNVEwPF7ye+z+kYDlLWwdtVBVhX+h
         Y9GocFt5Tz7jidPDeFtSfMreScFT6EDom0OOKCEqG4I09JbG6kew0RkvUT5hQcGx2GGq
         ZWz5eWFLW8ZqpLCTvyXz+NNaKLPP2y8vrcUAhjJHVyLQacpeNPcm6jU0Flbz1LFm+39a
         ahRUxIYsW67FpzKm2YMcXNOeYboNvmPJGQanYN8fP2Nb11QSMwUf0ZEm48LeNPItk3ih
         BAW4xgvblHgGOdPiFR2bwYIhiAURD1kEGzFQFSlxKEMe6fkvHzV94Vv0Zs/3kprpte/R
         2S0g==
X-Forwarded-Encrypted: i=1; AJvYcCXSCTRnHov5fBlAp4pbBN+Z2y4971SXiVWZ3J1n3JmEvEARUZBqoCJGbgi/AACC/PhO13RsPHDA9Yw2@vger.kernel.org
X-Gm-Message-State: AOJu0YxnT5pkOEX9MMOroMgvFD3OZznVIVMqHCrKWj63L7NpDLZPrNkn
	IikTQlsyv//+SjYUGv9PD9Y/JdmFsOL6y3QkMucZYiL5fh0Qg2Vp9C/GRGzvDqMAUEmhMWqZ8mf
	P9RWjUjIrJmz7GUOC6Q+mQLs5VFfGeTLuiKYrQp2f
X-Gm-Gg: AZuq6aJw5HXUsXw0YCGTB1+Fiw5UQ0YtQtlt1AAgzRzLqsdk5j8LlgNrCa01hP8SUmr
	PsIIE1AcCTZa7ubSL9kFwGJ2YxvRWvzAfdWCqm2+HOvZb+EK0KUeLedBE+TTFC0x6fI+t7k9k7N
	irLVzuAwdUcnD1Kff8unrI4JeEPhcEZoWf4P1GH+uoG46JDv0Yf5yrWZQ1wTThT+yJhFyZxQ+ON
	RUvLFPUDiy2hyIFH5MgQnrv7jptU56vkFiiPlL3PO4KxkMR7+pQnGOnSkocb7zbo8cYNowlrEnO
	v3EZbf95A1YsknqSF9OAVqEgoqVXUycgoNc=
X-Received: by 2002:ac8:5848:0:b0:501:3b94:bcae with SMTP id
 d75a77b69052e-506eac6b96dmr6584461cf.8.1771429952470; Wed, 18 Feb 2026
 07:52:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217163250.2326001-1-surenb@google.com> <20260217163250.2326001-4-surenb@google.com>
 <20260217191530.13857Aae-hca@linux.ibm.com> <CAJuCfpGxsX6kZAzZJZo7aGNxEbeqOhTV8epF+sHXyqUFOP1few@mail.gmail.com>
 <aZW5i4cqU1qUy3aa@casper.infradead.org>
In-Reply-To: <aZW5i4cqU1qUy3aa@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 18 Feb 2026 15:52:20 +0000
X-Gm-Features: AaiRm53m6s_G40CJP3vmJv4jXAYSm18GE46B6GFp27WgSQ5QeI3l-eaZ79M4lt4
Message-ID: <CAJuCfpH6c9q=W9ynrjV+UEpsoBpdoAw7ADchW2Wvnx+WYkaN6Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm: use vma_start_write_killable() in process_vma_walk_lock()
To: Matthew Wilcox <willy@infradead.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, akpm@linux-foundation.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, lorenzo.stoakes@oracle.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, rppt@kernel.org, 
	mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com, 
	npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 1:07=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Tue, Feb 17, 2026 at 12:31:32PM -0800, Suren Baghdasaryan wrote:
> > Hmm. My patchset is based on mm-new. I guess the code was modified in
> > some other tree. Could you please provide a link to that patchset so I
> > can track it? I'll probably remove this patch from my set until that
> > one is merged.
>
> mm-new is a bad place to be playing; better to base off mm-unstable.

Ah, I see. I'll redo my patchset on top of that then. Thanks for the tip!
