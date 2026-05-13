Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F843CAE76
	for <linux-s390@vger.kernel.org>; Wed, 13 May 2026 06:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778652062; cv=pass; b=CLEtgEnXg1FpiKtLwggQqbKQCN/v8kfwO7J6yzIgx4eRzIOFaYwbp3u2p9pCx8DXd7mZFpj24ja6EL7Lk1ln+AmGSqQ9shgwmf6BRlTx8Xv/vQ3mmere/WzOGioPMNOmzcbDgTFXdvKvdBAYvsJbGvuiQFwybF5s1nZcbifFezo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778652062; c=relaxed/simple;
	bh=qO6qLQCq8xrnlfLNLJEVsXfC/7lRKwr6FvDujx9vSzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbdBypzR0n/jAjAoatM8vW+56ZXtJNZoK69WBrsex4URaPGkEn9LbqttUugzdKSpRgYbeefTii8sBDbyPq/JT9KXioUQuAG2Tgnp5V29WttXycwNuxPAJPv97iOmf62Xew7o/HZTruS9ABPOd8qPg3f/0TMeX8IEPWyjT8SBh2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1QSLJPe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qXnIfeVw; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1QSLJPe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qXnIfeVw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778652060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HRz/D2QAgQw+T/kAY3igRtVmwBLEOWkLp9UlBFfg16Q=;
	b=E1QSLJPeQSmuvqEpz51n3UOzkCpyYaulb2ovudiY9umQg+MzPOw727WzT7Icx5A3l7wC1r
	mQyk5z4i1S1p+MjhWuwE5I1kh9iuUKlFaCCh9W5ia2I22z4wPc9snvC/bNJA8MPN7MmxFC
	BW/CCsGtgqu6Fhzwy4A2XC/Dw5PIiZw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-63-qOp5pKxqPCm9UCwf0CI1Sw-1; Wed, 13 May 2026 02:00:58 -0400
X-MC-Unique: qOp5pKxqPCm9UCwf0CI1Sw-1
X-Mimecast-MFC-AGG-ID: qOp5pKxqPCm9UCwf0CI1Sw_1778652057
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44a71109b94so5126035f8f.3
        for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 23:00:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778652057; cv=none;
        d=google.com; s=arc-20240605;
        b=ADsuZY2fX5gjAMxXxltB1Zkqxo+jyF5OZ/VMgGBXFxDui66FP2ox2s2oFhg2WoKCWn
         AhPYxSfjPkIgUejF1OIMEB7pMwixUW+qknGuvKZHQtwUhWGxZvvaMcxfDo3CIMDrkNny
         ftc0Wf0nUcWa2mRKy2HPKYI4iA11q1I76Nb+Y7WTMX3Pm9CrZWGzl1VdkIesxa+w5GQT
         ZPPTzcwDwwtlsCjrc89lpyILJfqcDD0J6jRXdMl38PT4yAEIsIlCemzXk+s60Nm3eVGu
         voS1A98H9m4MNkx4tZL4EKysKl8C6Y5z8r0PMQBghxu+N5HrPU9zRswrJPcmRoGmkbxZ
         pNGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HRz/D2QAgQw+T/kAY3igRtVmwBLEOWkLp9UlBFfg16Q=;
        fh=HKlby8vTd3uECEYhNf92KPVuVO4dZoWN3DmgsUNU6Bw=;
        b=ORgsjGdTiG1i3DJkFC5k1AydkCvoN4SHTWHfJ4AulaKv10Kw2nSGkhP10VZODqLF2f
         pkeeIGVROUCQsEIA1/wOLgq99K5eoDGs62yVcIQqBU9yxXt22rzfRHXEIw9eyTsA6aCW
         Qq7Me7eBnmWvOJWBxppMjXBLRGGlUShfii3XEopBnyfbuX4G2IG87PToaCdySYb6g07q
         kiCv4ZAhUPdCw13605VnlMOBAc5Mi34TjVekzWdNXTd7+HQ/0WRteziEKClzD2foWMy5
         +2++ju/cqzACrAt+SoRFZpl4Fjh5o+SX5nkpLY4MhtisMLa3RVa4XkMWH7yPAkzQjLek
         DlVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778652057; x=1779256857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRz/D2QAgQw+T/kAY3igRtVmwBLEOWkLp9UlBFfg16Q=;
        b=qXnIfeVwoE8UmKTin4NPjEHXvzJV6nPUvaWuI64NLzp0L0YuTXwmuItUJXW0DUiPGU
         jZUjcPrT7wh60f23oyqcwGpQssjkk+dEP7NEhuhUakpIe+yLZh5Dt0z8LHl+hcyfSMKK
         AXsbnnrUKIBg0Cj2m/K5AS62Go1cRy39QtsXPJ1GVB2CqV69ergE3L5b4n7xp7Uvpbc7
         58ZJ+k7JDLeXCJf63aoZ5LKdUM6IM8UtyVpbwQH9mwe9RqNdrJ/s1tIm+lreaJioDL23
         bL4qbxQGOqdoRUkt6LfYeeJnh0g38T8/6pVkaCxbLcn22k0JxV/wV6vZtWdPlH/ghPzH
         ZbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778652057; x=1779256857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HRz/D2QAgQw+T/kAY3igRtVmwBLEOWkLp9UlBFfg16Q=;
        b=DAT+umpk8Hzfzu9dvWn9YIqbRKImonrrl/IwAGLWN0Afh5sb6WAp9QlQimZNCII3nS
         99PUbD7dpUzZIiepIWto4YsQ5wkTBHBdjW2pdbmfKEYzpQO+Xp+C1B4H4ACD5J24j4w4
         +krIOkASgbo5Rsd4R/fLh+8K4u4qQ0VYUTcJk57+yHbwzmmBRNLTXvN9cBj42HF0ko8c
         CRjjnauhFqowuWG1JSa8dprvP+0Wx0UOX3eFg4fqfFlNAy2i7UJO6KB3+jky/E1Tqtib
         EcOvYNOmqm9yPvCP3cEkUZTbA3AzxXdV/heWtPqUAbdECJF/VnVgsfuOwkEQt5tkIiaN
         SW3w==
X-Forwarded-Encrypted: i=1; AFNElJ+8fqdEYf5lFuxTfS/TrQoDrWttER8+zya9DxuBw5eOCeIl/VmORYK3HLf6nzRbD1+J2InWlS/PaQs7@vger.kernel.org
X-Gm-Message-State: AOJu0YzOFwBwOGy3+5ANaTdPPDAJTlypSTHpMwsylAwp/1xapnKainSO
	9du95T7IqHkUEcWtHw5GWdu3bx9GMzGeCWkjfg4XnAtYEdrdwjwCH8M7Jc+GjgYgUK2DCqwbW+l
	2OzEAHDFzcD/E/bhOpzeaKx/N3//VRLEl92tVu9fowmEBYVHJ60nGh3HMBZAtH4z40/E6ODfC3A
	YgdhbO3RUes1oj0cIcqBT1c/gqXauQq20tb+EDlQ==
X-Gm-Gg: Acq92OGhOHE4gHRULR6l8PToLMqtKrTfqdUzVr8lyOHktm07hT/mMKGO8T6DpE/H1j8
	B96sXtztiuZ6m3rjQVHvbTJ+qc3arUZwyD4bnMFlxktU3TlzGBA5iWsV7xw6e3Sopbjk75hJAZi
	1VdcXctAJVHQLEeeNqOk7hux7A/h0ZMq7aXUJy+Z8Io+RLdV02s4b44dpvWzIRJdx1dmuRrzPKR
	ZuUZ+FUT488ljUXXT6h9zTxyflZZ/qbYwudZXIv1fTse3mV1caie/dsVcJkEdyPPOAdleY0YpVB
	CZt9OKf5
X-Received: by 2002:a05:6000:40db:b0:441:202e:3d2d with SMTP id ffacd0b85a97d-45c79a5844bmr2094573f8f.19.1778652057045;
        Tue, 12 May 2026 23:00:57 -0700 (PDT)
X-Received: by 2002:a05:6000:40db:b0:441:202e:3d2d with SMTP id
 ffacd0b85a97d-45c79a5844bmr2094486f8f.19.1778652056386; Tue, 12 May 2026
 23:00:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504152026.587578-1-borntraeger@linux.ibm.com>
In-Reply-To: <20260504152026.587578-1-borntraeger@linux.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 13 May 2026 08:00:00 +0200
X-Gm-Features: AVHnY4JFaakgD_c4M9KCMmdl9SUs0_-UgVt4TN__6UOzOrmt5oGsTFRdWgsvRCU
Message-ID: <CABgObfZdq7dzMvpVDpcfFAci=fKzfbpup_J0cO9be5EadC4QoA@mail.gmail.com>
Subject: Re: [GIT PULL 0/2] KVM: s390: pci: fix array indexing for master
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, David Hildenbrand <david@redhat.com>, 
	linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Thomas Huth <thuth@redhat.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Junrui Luo <moonafterrain@outlook.com>, Yuhao Jiang <danisjiang@gmail.com>, 
	Matthew Rosato <mjrosato@linux.ibm.com>, Niklas Schnelle <schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 5:20=E2=80=AFPM Christian Borntraeger
<borntraeger@linux.ibm.com> wrote:
>
> Paolo,
>
> The following changes since commit 028ef9c96e96197026887c0f092424679298aa=
e8:
>
>   Linux 7.0 (2026-04-12 13:48:06 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/k=
vm-s390-master-7.1-1
>
> for you to fetch changes up to 0cfe660559e857d7c00ab86c73e4510ce069086f:
>
>   KVM: s390: pci: Fix aisb calculation (2026-04-27 11:14:45 +0200)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> KVM: s390: pci: fix array indexing
>
> For large amounts of PCI devices its possible to overrun the arrays as
> the index was miscalculated in 2 places.
>
> ----------------------------------------------------------------
> Junrui Luo (1):
>       KVM: s390: pci: fix GAIT table indexing due to double-scaling point=
er arithmetic
>
> Matthew Rosato (1):
>       KVM: s390: pci: Fix aisb calculation
>
>  arch/s390/kvm/interrupt.c |  3 +--
>  arch/s390/kvm/pci.c       | 10 ++++------
>  2 files changed, 5 insertions(+), 8 deletions(-)
>

