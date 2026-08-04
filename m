Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A95F3F54CB
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 14:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785854082; cv=pass; b=psEMemmhsoVCcj85+YA6dR1OcPQqF3N+v6yWu+Xv5QNyCiYG47suaNndh4wXMh9ZnWok4pf4xKpN3sV5tep7Ml/Ptw7bka+M/9iB5OIpFs7BvVQ2Erp7/7DRbPOQJ00kVZrCUR9+uNZ2UDKq+S6ax1JS646UgqML/z3INQZ8e9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785854082; c=relaxed/simple;
	bh=AkpbKoqkLE2ago1nKO8zeKKdehNgTrIPaOMhneanm5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UnjoQpgU/4ilwU6nwvrYzggND40em71QTDJgiuRXDR4y0aNFOpXu5BqamFezVzL8BeQ3LGD7uS2SRfstdwckO7Y78msfXVCpTaU1TDPosysv+IB5HEZMpghiD8W6zyii08WzvwCOZbq7Z3XGELtlB31QKUIU9nwTWihFcMISzxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wen1quMp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oeMRMRpR; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wen1quMp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="oeMRMRpR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785854067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AkpbKoqkLE2ago1nKO8zeKKdehNgTrIPaOMhneanm5Q=;
	b=Wen1quMpbSOzOadmkezylmdGbASOg0MUgJ+euD7NXCwzxDDsXqJi1qtizDC9U7T7kfM0eS
	CEt7CdX6eSXUgxpoJP5TIjurWuf23GMsG8012aqfpktAAlzd6FLqws5gQ5uUDb5gqG4dgC
	G+aZnDatPu+nlUBVBMaCIdPjDLDC0OY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106-Bz_oAC99NWak_I9KdaldDQ-1; Tue, 04 Aug 2026 10:34:26 -0400
X-MC-Unique: Bz_oAC99NWak_I9KdaldDQ-1
X-Mimecast-MFC-AGG-ID: Bz_oAC99NWak_I9KdaldDQ_1785854065
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4955e865174so19843305e9.3
        for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 07:34:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785854065; cv=none;
        d=google.com; s=arc-20260327;
        b=XII5uvvqp8wvKiRtAUzhFzAJ7cCpfJ5AS4dGtCzwzbGBBuDf/SNdeLZyxMmQFFMKcP
         1Jsek/qACxVgdnpZInE41w3w77ZbYCVZIVhq9+AaDpi57lRliBqgrSq0lYCQN7y4iLPz
         l5srq++4pnpZxw3BF3J6PABNyfdBh419yCReVDSeH64V4w3w9JkzTC0vTuP3HFX/QV4+
         fpABaLmYbfsBVOd7N03byLJymVzbQKth1D3jWa8jtJEb/6O8qPP8CWQ/cRiUBXCzaUOj
         CrTAEAlMngg+99PYXW7XNCfsY2Hfxx8dSTnsSRNmlS6j02JaD3RN+zMu4zJroSrIf8DZ
         YeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AkpbKoqkLE2ago1nKO8zeKKdehNgTrIPaOMhneanm5Q=;
        fh=MDiQ3WeA1tcwgK/9mYi2K8n5gy6Sx1FNCovR8DxERSc=;
        b=otPaV3uk/tyi2qJ6rD6F8xddUzFpB+8ylCnIXvkUPaES8NTu2CQ01efBwL5vF/qx6i
         zDSh0y3X6sQsVotq9q8J55UnaEBlx3X4ZBJaSh2heYmGFJb8uPe2Bk8lvDZ4uMM+eYpq
         iInvxAfzWh1/pE019zXZZAKt+062DpQc5BcfFeSUJDnhkLN2l+ST8IWzEvJ/UC8FQySY
         k/ZRMrhsiHUQ33PoayGuiZCs2aZzocm2IDk0iQUeAwLBf/YGScL8QbkwM47949av4yWx
         zxCAIulXikMvCxUcCV7uIWCBIOajJgVgFj5035UPrT3LyycIsTW5Qrbma8v+Gu2R9Yc6
         3oeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785854065; x=1786458865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AkpbKoqkLE2ago1nKO8zeKKdehNgTrIPaOMhneanm5Q=;
        b=oeMRMRpRXphJnO2A7FxxFVB0wCiMjMW8eGzqDqv2/23j2YgrmWgB31vK8yab9wfqmT
         jeXV01qn72sI+XW26nr9Pp+VaUaYtCIwGOEN2kQTbP3Y5NDiF11zSq+99UbaZkOJkRn+
         lP98cWMUkl/z3pBC62N3IYiwBs9uXTzp6ONVbnk7Wy/UqTkWYoDzNuetR4hI57Tb7Gb3
         /7h/ywWBQEAF39kFKL65t05fzKpIOE81lYviqwnR+q/7opfdn1AhQ2bxyR0eP2Wrozuo
         8Dad5ojqaEsh4lUNarBzp+AdKK+TZjHygsQvdW9wwyZz9AEkOYm7Q+BmyYiQYiS4PNGE
         T9+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785854065; x=1786458865;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AkpbKoqkLE2ago1nKO8zeKKdehNgTrIPaOMhneanm5Q=;
        b=qomkmTF/tnAAFaDBkUueS/F0Zk59DCKlbnVembrGfsXFtXrBNTWRkQh43wwECJA59F
         xbs01kI6clDOA4a8Ulfk1DpuWbFhK7/ujM9mYlcK+72Vg2MHKykANzQ8sZggnVvnZrOZ
         SzRp0nfmRB/zW1ZZOx4MMQwWk9wn+AAwUa5dGOqLbNBZ47wmQOqNyr5mm2/Yz2r93Lw9
         bSI5ItUdQMaUSsqKBo5CNjMje/nN8ncGXXNDwSsNB1OVvpJsmsA5gLj/K9K3LOnUgHXK
         Pg1Rdr8RO2uMzTuSDcn5M7hmEIwD3m7zIRvXHUgHTpNwj/n8iBRx6I45QJp14CyC0RNO
         vdmw==
X-Forwarded-Encrypted: i=1; AHgh+RrGXjg2LkQNxZQW0kquDl3np3CpA0CXTecCC75Tu9Zzug3uIhVpmBLttLFUZIJD8Y8GS12y4Uw8MPNg@vger.kernel.org
X-Gm-Message-State: AOJu0YwvrfNO8ZWrYs/IG6pL1qlAgb65MW9xj9OgV42FnBsZKByzuPHn
	D4tKaJNrv+LSjDb9M5AZe72muweshM3uPNCUZegR2RhxnAdtjWCQ9TL7UJFRUaSwqVy+7n1QWB3
	zaBlw2v6sxAYHrZNA1JgkgI/46vt7W7ctL2THubWTHg0wvdpPYGqh3oEWL0uPnennA+5zg6G0Si
	d8eY8ewx6OO5jZrHUXnP2NWYu4iFDxs1FZtO/Ryhq5mnd3LA==
X-Gm-Gg: AR+sD10MAMyp0+P1vPXOM6Wqf056NPrVuRtpXpouDpYjuDpphRbY0Vz5mZBWIIPdXmv
	lneyDLaMcUkbw60JW8iOYz2eqhjFLTnVbUgwgD/vAdzm8KQXP2oP/0ScTN07YocTwnslpvuxlxW
	AS30EnmlKCrPXbO0+Ab5cEnBP2dvU3rRBZLC1AVXTh9/gFnCZjjyUEbJtafgkpDDhMS20HNG+7l
	VZDdWWFKbSOC/2tOwxvAbZhrGmZ+sCJP0CAQsoRGtIJaqFIEI01bj34HHo=
X-Received: by 2002:a05:600c:4fc5:b0:494:6baa:ccef with SMTP id 5b1f17b1804b1-4980f23257cmr337368905e9.11.1785854064922;
        Tue, 04 Aug 2026 07:34:24 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc5:b0:494:6baa:ccef with SMTP id
 5b1f17b1804b1-4980f23257cmr337368035e9.11.1785854064514; Tue, 04 Aug 2026
 07:34:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com> <20260804120529.1730187-3-pbonzini@redhat.com>
 <20260804161549.4cd9a66f@fedora-21.home> <20260804161850.58c55c6e@fedora-21.home>
In-Reply-To: <20260804161850.58c55c6e@fedora-21.home>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 4 Aug 2026 16:34:10 +0200
X-Gm-Features: AUfX_my1qzxj9_dJklyDF5G5un-IXavjOuTxcyczoqFAniCfVGichGNEROtCVP4
Message-ID: <CABgObfbAveuhkjXzmemvGtycmcmDePKABr8Q35Y9mZP0den5aA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] drm/shmem_helper: use vmf_insert_pfn_mkwrite()
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>, bcm-kernel-feedback-list@broadcom.com, 
	Christian Koenig <christian.koenig@amd.com>, David Hildenbrand <david@kernel.org>, 
	dri-devel@lists.freedesktop.org, Fei Li <fei1.li@intel.com>, 
	Huang Rui <ray.huang@amd.com>, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>, Sergio Lopez <slp@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 4:19=E2=80=AFPM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
> On Tue, 4 Aug 2026 16:15:49 +0200
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
> > Actually, if we're making the drm_gem_shmem_record_mkwrite() call
> > unconditional (for PTE and PMD updates) in that path, can't we drop the
> > drm_gem_shmem_pfn_mkwrite() call living in drm_gem_shmem_pfn_mkwrite()?
> >
> > Also, I'm not even sure we can end up with write=3Dtrue for PTE updates=
,
> > because our pfn_mkwrite implementation returns zero, not VM_FAULT_ERROR
> > or VM_FAULT_NOPAGE. This means the default RO -> RW PTE upgrade
> > implemented in finish_mkwrite_fault() [1] will take place. If we really
> > want out try_insert_pfn() to be called for those RO -> RW updgrades, we
> > need to call try_insert_pfn() from drm_gem_shmem_pfn_mkwrite().
>
> Nevermind, it's all explained in the comment you've added. Sorry for
> the noise. I keep wondering if we shouldn't call try_insert_pfn() from
> pfn_mkwrite() though, like is done in other places.

No, the .pfn_mkwrite() callback is invoked when a PTE already exists,
and mm/ already takes care of making it writable. So there's nothing
to insert, you just have to take note which you do with
drm_gem_shmem_record_mkwrite().

Paolo

