Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6633C9EE4
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847497; cv=pass; b=oPLmenHwnkPUyqvjOpu6qbrHVEwuzZLqys4L8fzy0HeG2inmfrK1Aaqs/bGh/Ly/pzUvNL/bdMCAunfxMPirbNGk6L+v8hMYetZncNwbFfgpq0MIOpKfrucRDYL+8Wosz8CkbApWgF5KRPqsDT7LwtYVSLQAqAcJ2Hqxf1VAvNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847497; c=relaxed/simple;
	bh=AhCvAzGz5QWbk/302ntoX0RJ56FBrV8QY/YWkhL/+9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HE2O3hn53PSrv2KKtL7e05INebk1Weko8ABtsh/Soes3FExVS/bhW4Ju/V/Kr7IIBiofgXySCRW1XqkawgQBFkGpKoGpkM8P9B7HhFYsqWw7h5kAMr64WZGsYJSaA16einledw2mXBn5UjpR438bAYbxW1pKVkUt73OdCSFjNTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KPxFt9EP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LbiiUNS9; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPxFt9EP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbiiUNS9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785847495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AhCvAzGz5QWbk/302ntoX0RJ56FBrV8QY/YWkhL/+9Y=;
	b=KPxFt9EP5GqxlwskjyT9NEkaHe78JKqmsKYItSZhw60mKXod30UVSdN6WP9u1snf+2nfrH
	J6ZnP27ES+bhftOpxwBm39+EoFeCLWkRj4QTYZ8oqRXhI+QzNGn9xGwSjwpV76wiWbSm/H
	U0sDkH3x/BOx4nKLjOB/JI/9/L8HHO0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-TAfdbB_wMIyTY1rCegfPTQ-1; Tue, 04 Aug 2026 08:44:53 -0400
X-MC-Unique: TAfdbB_wMIyTY1rCegfPTQ-1
X-Mimecast-MFC-AGG-ID: TAfdbB_wMIyTY1rCegfPTQ_1785847493
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f8f8fde2dso3448953f8f.0
        for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 05:44:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785847492; cv=none;
        d=google.com; s=arc-20260327;
        b=LmjiB1gWFDX41tRRJKP4bFRwV9EjSMLd0ckjNtDvyHJlnLV0MBT8cFd7Eeuwi8cVUG
         UymttgXI6NDImuSrVpsXP+IOEQpt/LAkp28CfsKAtL4/v5uUzpajeYTa35/kdNhbEeHA
         v70/SH/4UTgbd38XbNnKVzwrJ9Pd9GKAHtUgrZri8WRWLQ9RkztzPFivFhdM5FDoQMsW
         bY63OSbrXs5kFoR2X+PQAlTO7PgAkIu3L5OBn2IT7LwDImfbChThbhSiEs9WnX1DbWop
         fXhFYkLb5T2CdpBEc7w3ubhTpUvrKxl6Lch3+3LYXu6Ji7g9wH4Gj01ZGHWNwBEslLLF
         Xm8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AhCvAzGz5QWbk/302ntoX0RJ56FBrV8QY/YWkhL/+9Y=;
        fh=n6TYtiHw2BAcLZPaSL5w3FELPcdoPYDwT2q26lH7bQQ=;
        b=YIjk3IyoPKd52qnjhnBBuGYp1aEGCZHSjn8U9OX5ftjv1DOex6vl8MbUuqjmbwWSRM
         XI3wS1a2ENmvQE/bUwAWOlmizTgxHuyW51aXtNrtiG+z0ZshLx6omP0VekTVVkiVjZ+2
         EE05iU96YQ6Na01q/tM2/OY9TVm56BNe0OLU9IX8IzRWDvnVmXdB+AheZII1K1OuE2cM
         aewwRvv3ZPrfJjFgwRRJXVVCu1QUeah/3e57A1+IPhAibpRc7w6mzuGQAD+pKBq5SkRw
         QsMWPkhZdjmOQ7yw8EW9xabHWIBN3SC/ZuFFKEZ/Xr3zBNy7rxzoPGDH4WhUYVn9OJVu
         gUeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785847492; x=1786452292; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AhCvAzGz5QWbk/302ntoX0RJ56FBrV8QY/YWkhL/+9Y=;
        b=LbiiUNS9WLDU22basKkI55N9OCI92YtF+oGsC1mZvnztuffOsRPJfTrGs0MJUQewUk
         iUlYCYN1LZbfCi08s6UQjBpAOVHoao2BRoIoO9bsh6TDj0U2hnkuDmQr67N2+EIwiGuf
         +SnWity7L8nXz+dy0ZOGpX7gndjtogzPCTF+iJbdWskRIscDAyxy02miSu4M7EwAIxw9
         poSEHKoXrGJC77/xvgUyt0Nv9U7fJS6S20vvNZ75Ns0HelqsU4IUFIiidaZye79Huh1h
         1n3bRV9WU0/i1Z4RQQEgG8DDc+MEhEMdmlJFQPo86oEEduLsX4C8/fnUNwE8cmxn+DQ0
         dwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785847492; x=1786452292;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AhCvAzGz5QWbk/302ntoX0RJ56FBrV8QY/YWkhL/+9Y=;
        b=YkWhaEeSv6t/YPhXAY3Vssi8GzchdRzrC3C3voTZxX4l9r6O/CsUgNSo1BZ8AsHIQk
         2PCsAavZXKrdkVl6UjzyVv9L0Qi1z1DTXK/AxCbUXEIP1DNwxBAnCIV9qFht8rdCc44T
         ecsSM7GBvAsMqDkynqgb54Xuk58krr0OCossqSUjpdAuEEmEePMBeiLM1H+26HKSyh52
         ZBWeyvIbPek80fPXrB1ZGu6Oa1oTGk7VGDTfwQiZJi/h21lyolCJI4gy0eiCMaARo7jv
         NZaakp9NzjV2VY6MOnTze26hjG0QEkwKMUvH3sbnFYnfWfgG5/wiBAAeMUEL3nFdW8mH
         p3sg==
X-Forwarded-Encrypted: i=1; AHgh+RpGDTL6q14sZuqQ7foE4YV5cQe120/iktbvelJCVUFJ2Irv30G/2diIzEU65QYm/YAvpmxQwAaG07Me@vger.kernel.org
X-Gm-Message-State: AOJu0YxohC0IOzIR6wmMFU7YDvkWRIz/Ri+GX3PjrOMTCQq6yK9/agxc
	epNBeohL+vveN1HZhHWcn91zD4hAgiuGApK7ibBeLUtTcNE/THbSAgg4SCKH03PdtsQvpM28dRw
	hwWgE/93qz+hUFeAItWTec3P6SYL5nODt+BTyqwDnazESqgcZEcKRgDEmz6D8f5XD3ynJqycKjF
	HKoOkZ9k7SOsZzWH0CbAKJjYs5jbJlS7mbLRCtZDxm4w3Ykg==
X-Gm-Gg: AR+sD12706dI532tCymNeYjb82TNSFezxz7in8lIjlkhWv2+zg6Kqntqq2ImZJ8XPLJ
	jzzreAlJcut5MXavDeaAsiUP2JVIVQWRjzDLsiWrktl5Xkr51H4hwMBdllTqdYLpE5QDZS+QDs3
	IDzvrym3Pp3Gmi/jwnxRph41yzBE/zxCawS6EExONjvctv/uZDbQoT4r0H9MgreFle7WRINlKqn
	cgpc/1/QyyiMa1vntJ2g6ZRvMWrNb1keYV9yx6CxYRpG6Tafgu//rXrAhw=
X-Received: by 2002:adf:e196:0:b0:47f:91f0:9a8 with SMTP id ffacd0b85a97d-47fd72d9daamr44077328f8f.23.1785847492560;
        Tue, 04 Aug 2026 05:44:52 -0700 (PDT)
X-Received: by 2002:adf:e196:0:b0:47f:91f0:9a8 with SMTP id
 ffacd0b85a97d-47fd72d9daamr44077224f8f.23.1785847492081; Tue, 04 Aug 2026
 05:44:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com> <20260804120529.1730187-5-pbonzini@redhat.com>
 <20260804122348.AC6E51F00A3D@smtp.kernel.org>
In-Reply-To: <20260804122348.AC6E51F00A3D@smtp.kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 4 Aug 2026 14:44:40 +0200
X-Gm-Features: AUfX_mzeBd9D7i9RK65m6Y6i1uzG2a-w4C9IIV172eXDDgUNWsdPG5F7opYXrlc
Message-ID: <CABgObfbd63O_UkmCcik1z0J847Sr6a5rnFgwttBjBb0am=+2PQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] kvm: apply VM_READ/VM_WRITE checks to all VMA types
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 2:23=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Write faults on write-only `VM_IO | VM_PFNMAP` VMAs are incorrec=
tly rejected, breaking guest writes to write-only device memory.
>
> If a guest performs a memory write to a guest physical address backed by =
a
> write-only host VMA (e.g. VM_IO or VM_PFNMAP mapped with PROT_WRITE but
> without PROT_READ), get_user_pages() will fail and fall back to this look=
up.
>
> Since the write-only VMA lacks VM_READ, this check will evaluate to true =
and
> return KVM_PFN_ERR_FAULT, skipping the VM_IO | VM_PFNMAP handler. Could t=
his
> prevent guests from writing to legitimate write-only device memory, such =
as
> command ring buffers or write-only PCI BARs?

This is theoretical only but actually a bugfix, because KVM does not
support write-only mappings and therefore it would not be possible to
enforce !PROT_READ/PROT_WRITE.

Paolo

