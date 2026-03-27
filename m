Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961403FA5D8
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 17:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774632761; cv=pass; b=IS/dYpDTvZZ6Z57UBzm/wbpRDRmbSD9ndBLor0Rff9NlTtvFIOxyCeWrmizs6ePxLj3Yd9+I5zE9EsBUx3DgwCAkD63YIERP5rPJIlplhxh0pVg/5ITtrIa2E/UQX6SbANKtqdPg1u45av9zmPJ11srPs7FR/ct1NUUldpeTuHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774632761; c=relaxed/simple;
	bh=xn4jfIlqJ8j0SglUOPqzBzIxBo2F6zmgVlZu4AmYgAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lByUYNFOqbeMje5xvjb3sW2fJlCuYy9Duqjsh+hj1zIvOyoG0GHL1lH5C3DQN47tSImK77l3Qoyn9dBQiNbfRCUa4KUNyUZT+Q2yhJ77+ykyobGrC/4qgZcFceuKR7nFP2l/BVNc4ALIVP+TaaHDWRwbtsVbNaLx3Oh/7Aqvkek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vM1DOUFg; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vM1DOUFg"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-509062d829dso32891cf.1
        for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 10:32:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774632759; cv=none;
        d=google.com; s=arc-20240605;
        b=OBsl8cvceYMx0IrRW6yDXdu2nTwTATAiDmifeRHt5Oc1czHLiAidY80wSiKoFCRvXg
         pPxGW9J9qVGWxv0sdNzhFwcLxt4TN6nTLLaGPf5gZay5So+/ZWxkvJosunxxkDq92hKg
         aUE5q+07VNlqdzYXQ24vSL9VIO2tfCGL2SClLdgGA0JgkJih0Ry8QX1+BFYt/I4XxWNT
         7h7t7guX2taJPENjTkaZpAHSodbywGQzISNSeRvFDLqJRrepUQ4/V/ucn673YlU7sOHP
         GWdOWRdhMTZUx3s9R45IdY8vTekYaXKsKQz/a7tTIjOJeJV3XhMXwxOuS4DWb0BURURe
         N49w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xn4jfIlqJ8j0SglUOPqzBzIxBo2F6zmgVlZu4AmYgAs=;
        fh=KAgMAr+kCfi+GXiAfI+JnKomZLE0sBpR/NRFfMRWun8=;
        b=UxpI3HBJECFQk5IndPV0//AbQO6HzFkjzSY4V+VodNwmo3Ag/dC4XEzwnnAgx6eYm6
         oWYbpG1xgRfFzXjrefP3/NLJRKA1jLHpKh/yCY/U2X22Qlf0ih16IeWh6GyNMSW50t/d
         5iJpksrCahmy5WoznQp56YUkBiKxO+UPiKERsBij9ESwkhvyUbXeh/5OrlXhpOxKykG0
         sh41sJg6G9lDj7VQAyoTROu5bMm7UkYH+RxQM6ck/K05rteBQDZOAv0SzYfLwu5E79Qc
         cA/jOZcQwh/ySmxok6/gMh1Yx/r/92k3HRa7QG9ApaeIkgsIyfvMMycd+bz7tZ9p8kzP
         gyQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774632759; x=1775237559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xn4jfIlqJ8j0SglUOPqzBzIxBo2F6zmgVlZu4AmYgAs=;
        b=vM1DOUFgxvUQcPEgb0q3du0IcadHXlhcgmuFmYJBSFYqjoHI6Ok0t15jST7697ES+f
         GVFO/6niFoCnqPPvWA+n/tYB3xBi2mx0oXD3cYBOui/tgLxhLYgP5/JdrP8mbxKXKnbG
         pY28y/YFlRpUInPQ47UUZd9fL/DB64HYyrc7qZBRcLLZeY7M6Pvz6UHQVhNo9zHgJik5
         H9/GeDLUeox+AIWeyv6BDn14XS/3ZtLKThh4zCGXxo+rCWI1QPBCoe1nGzSyfg8ZXsZn
         EjeiRzwCsIvgjUfVa4K7LP2qWArHEFsWPppuPiUyP6jZdg4eDZJ1eDB+u+nYYdOyVqOA
         Hk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774632759; x=1775237559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xn4jfIlqJ8j0SglUOPqzBzIxBo2F6zmgVlZu4AmYgAs=;
        b=T5KzpOo0e4u5Kr1UPlNOZu2qAapF5z6Zd1ttwKTla8P6pYAKMfEI+H6qSU5lJyrikJ
         yu9F3JnS36Dkx6VMdQVtboEaFent9hVeCqYq3kg0wisC0O3TXRym4CbVdUqnJ4pJsxih
         Nkr14/ckz2fhgxoM5H8ZzrVl0YbNaheuCjRJS5HGoJcFDiXUMi2ygvtz68r/v5dgT1Yn
         N0o77icgdydHM2RdfsIwCvgTPTnJInL2mNnVgZpg2eQbu90hNGtBqCKUrbijXkh5g6OC
         vXBOpsYfEPD+tpsfaae//9PiJT3LgyBrwkbTv51oexHrdc+bKqQuG0ZMXsxRACvQiAmF
         zY8g==
X-Forwarded-Encrypted: i=1; AJvYcCXkvi1YCMFE8X0ZTOkNEDV9f/R7hCSv1Rk3DChEY67BpVHdT4LjGNwGj+3Zqy09xl42vDcEmcsP4hKk@vger.kernel.org
X-Gm-Message-State: AOJu0YzCflUEnFRgOPCWoCHkt0sdmE+nyPtGXDPhYDUmrzrd61/vOXBR
	S/3NeDzS8eUFbO82xyyMIsItjIaBTWL+/4w5OCvHwZBpgM7UZF4MSlbqWlE9yERbkmq2ug3hk+8
	i0a2PwsfJVTaHSG4UJB8ikjmpi3NUhPG6cwxK7sGo
X-Gm-Gg: ATEYQzzytR0qWO+bNOC6DRgdxRrTXTcxouKycFSFggIWGhS+WmNppk3vAtUcSj6U0d+
	KEzmH6nZIJjF/895AkcyHsEE58VS040ENYEZEG8T/dQtAbkoYsWigjuOCqN2FW+LveRqzVaJQcN
	cvtHrmy0H1t2BAxkc+xolv2UGYWaY0haQC4XWqyQBpw4bU0yXqDAw0xIvqySFGICfNy+7f8NInJ
	XuLx8AjDDsEXXXT7QQEWGe44cPaeC44ZIiA4TzsXErYoYoQU/5J6HcGsHSrDCy6dVDO84QyVngw
	CeRks3mPTCMh1tCJN2VrHVNKoo1CKd9RCtKD
X-Received: by 2002:a05:622a:8c05:b0:503:4bc:c925 with SMTP id
 d75a77b69052e-50bb292f320mr200991cf.13.1774632758893; Fri, 27 Mar 2026
 10:32:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326080836.695207-1-surenb@google.com> <20260327094738.7150efc3b0619e6ccf095c23@linux-foundation.org>
 <20260327100322.b539f1a9f3662a0a4c080cce@linux-foundation.org>
In-Reply-To: <20260327100322.b539f1a9f3662a0a4c080cce@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 27 Mar 2026 10:32:27 -0700
X-Gm-Features: AQROBzCNRgKBqW9q5PX49UYqB837bDipJe3mVx90Rrm9LZ-wrkWrRewJtwtbwBQ
Message-ID: <CAJuCfpFxZsnZqqfoKXX=JEBrBaqZHNAgBE0VHbTc=GhQzP7X=g@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Use killable vma write locking in most places
To: Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, gourry@gourry.net, ying.huang@linux.alibaba.com, 
	apopple@nvidia.com, lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, 
	agordeev@linux.ibm.com, svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 10:03=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Fri, 27 Mar 2026 09:47:38 -0700 Andrew Morton <akpm@linux-foundation.o=
rg> wrote:
>
> > Three of your patches lack review tags so now it's 65!
>
> Three is now zero, thanks Lorenzo.

I just finished fixups for issues Sashiko flagged. They are pretty
small but important. Testing them right now and running Sashiko
locally. Once done I'll post v6 and will ask Lorenzo to re-review
those specific changes. Sorry Lorenzo, I'll point out the specific
changes I had to make and will try to make it easy for you.
Thanks,
Suren.
