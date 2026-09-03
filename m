Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB8A4EE870
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788453697; cv=pass; b=pXsaetT6upbtVbydTMtYoKoCxFwzMkNx/pc7AhTJR0amKBagXd9s04PMQqkqmxOFkiUNrfoyKa7Q5RUgvrh/o+peNijhC1ceQ1BeJSMBrCxgCv5Tz6a9TQ5CIn21XtnOLgfTUor/xaYMrqC2ttadubH/+tnO+LAb8ZvxNcecNkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788453697; c=relaxed/simple;
	bh=jmE5t/QWYXGduwCXTsexmNTSqycO4dgO83zrtscZu3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvXqelN802G2Zfo7fvoRiSrK1r2BAcULTI4oaOHk0XPNTtOtxdppvi52wv7V8cbkVlqtf6Tw67b/ZlPzQEQkLLmifNQToR/2t0VEeSYuQRnVOqu5s3OauS6u03lDb4Rrbx5hv1CrJWDNbxBaiRnMuzn8S0GWlSi6athL7a2ZPRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bFN9NjMB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ByO3dj2J; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bFN9NjMB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByO3dj2J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788453694;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=96jSKrblNa/MGHlSRt22d1bqrg1HZKp/dYSrKcWfd2w=;
	b=bFN9NjMB1PGgROZP967lUpqy3JJf2a4AmMd4ONO5zYagyE2tW8LqlwAUNbApu20qbMSV2f
	j9lTNQw+G685Ct/Ud2hgJhgLS/M6hnFTgg+vX3xTCAi2+infDng6QbGEyjuyuPZPWpUCWz
	1VY7BgbOqa5DuyKc3geMZZWmQahgarM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-77OmuuRCNlKgrWVNDmAa4w-1; Thu, 03 Sep 2026 12:41:33 -0400
X-MC-Unique: 77OmuuRCNlKgrWVNDmAa4w-1
X-Mimecast-MFC-AGG-ID: 77OmuuRCNlKgrWVNDmAa4w_1788453692
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-484362cb000so16001f8f.0
        for <linux-s390@vger.kernel.org>; Thu, 03 Sep 2026 09:41:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788453692; cv=none;
        d=google.com; s=arc-20260327;
        b=sbgX/Q7sFT8Rmk88jIVFb0S128H35Sl4kEVQRH5342sMwvqIWFluG/5d7g2wuSTNND
         TndV9F6Fcn46N+w2h7EsgmIJI2qHx54ywf48qQZ4+alenet0xpZ/DuPgASYW30ac7T0o
         EHUOiHPaRBw8TdqVll+IKRUaqi1sn9FNhgY60YBpR2SROV+M8zQxCtBfqswKY0/K3v9Q
         lNAzCRHGpLLexeVHE+TTcx/aT09mCgwr8a935u8iKBcEf8F01jtA1AUo1Z4D0SA0EEhJ
         eJ8BPmZF1xBbTfFFRaeBKboCI9EVRwJpgwKw8/oSM/T2srdvDefLrGl0kXNqUiiO8fsF
         ukLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=96jSKrblNa/MGHlSRt22d1bqrg1HZKp/dYSrKcWfd2w=;
        fh=tHU4Jzdl9DRt6X8I82/G/x+8fybHThha0Yk1G4LY8pM=;
        b=bhzb2FYvA70t0BcMw3Kfm6vZn+oqiVAoB56J5ETsMqcFxtq34ooBbcDMRmY/xdzaDN
         mbeMKpIoSkS4lUcLLVc50dISKbCZXMtfUS6Q/rZSamRqRpQDdcqVLzSQOiPrdNlCTe1m
         ZJcgHaCBF6dqvzX9q1Ty0/Ai7EK63q3gXeY4IXfGqw9noe6k6VjTBR7xxKuBS8hmqM5c
         bWM96flMN2LraEv5D0WHyiNp35hFDaTsI3iHxJto3QznVYARZxP+ZMMTr6FmJFyJJg8Y
         wVta3Sjo30hGhopGxxfX2ETx9R6mue/L1y2uPC2IiDw1/0sHmU65G81IMEaBA1RoB7dS
         KZsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788453692; x=1789058492; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=96jSKrblNa/MGHlSRt22d1bqrg1HZKp/dYSrKcWfd2w=;
        b=ByO3dj2JbfalBQKaZuQA0LvU+B5tRWZsqkyx1ctjv/yXklp5JqEcKRMof+z/H1ZFQX
         meWNtFb+OK4BLy/kIzzp3EVxnWzU7en1KdTQizQomRQHtySm9z3Up27vdVoGTtuYymZm
         EczFj1MGuI2vMOUbp0QmFIgj3opCOO6EJGRcVkJM/f/AsNaNUeQutHoO9iWxNazcbedy
         1/GF5jVQiy35qDbYezKO3ChOk1CnDTlFebWL29JvfZC3ktZ6znJBYOxdTPm/6Dj6RT9Q
         FaB4ieKp12fnhhTYvWV9vOvirsXoPqkoXVdtr35fA1OruqQY8svFt5ViIGK9SBypmaYT
         1OTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788453692; x=1789058492;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=96jSKrblNa/MGHlSRt22d1bqrg1HZKp/dYSrKcWfd2w=;
        b=qcLI9I3nVlSAfdU+sD2CJgwkcEmUERwo+YO3532siBL0FXUMDFLqLHSeTcwIEZTZ/O
         P0F93m4WFBk2SemiP6rDj/llFF3pVLUICBii5ma5NtGzKYk39heQ9GjKgFhHOEa6xKYE
         v3JHmbowfsypVQOeLIFrTsB+cHs436+KxD0qrd8kNlox5P5RxEMeI851VLYd1djSI2kh
         56+YIhvzD/JNHToMkkHA6mfXiuK8/80EA/DILZCgjmDEe1wvMLKD7+OP178h+PLHwi+x
         cC3n518fdn1YplEOIpHo7IUJT9LnbWvqRbD/KCul+svcy5vvDd1nXWj41g3O0jLex/O+
         UQIQ==
X-Forwarded-Encrypted: i=1; AKwUvByWBlHUYtwgxc96rXEIQZomQ3/Baq05UYDc0CxNiRzLXwF6nq9NJhWgzTFwlUHcJM5GZ3Fs8sWlLLb4@vger.kernel.org
X-Gm-Message-State: AFuF++k1mX11TVPiZNiVaMQzglqM7IbvuDn5bl+or1YypexiDZitvO0e
	ylqY0oPvrlDqjj5YIMxh1p4EwTZBzcovLGF8O2IyDnAQbTmD45SiC8zFi9ibzWqbHTtasKWNQq4
	a/VN6O7EfBn0Q6tIFChizBFDye8uEYR1bKD6bwAXu23oxF3/2K759cDBfuuXuKznTfbs6sSUD/2
	52jkaXxaV8vhgjudpdrNUqQOhQkbvQsjnvG+CjwA==
X-Gm-Gg: AYBFou0s8mvmIubzLq8lub6fXHaGjcCKKF4sMSnHi5o8gOtSqRWP44muGyGcaCTfD2F
	5KjY3gr1ir1yFwAXqIavrHmZS8SK43TJpKJTwCczNLW+1tS3DfJzPkLeYYVKPPiKDqiaNa5rkR8
	jHIbMuauYSaayV0wFgBBnmv8Gsuhj/K8nRzNyzt+BsCGo+7Mp2SriLZWm1ldI0Cl1yTBkf17M42
	koLu6aQcAy0oVXEsx1sdiLTIh5YLalOkhdHIXz3cCelhtJZptpEq/owYSI4
X-Received: by 2002:a05:6000:22c2:b0:484:3147:49c9 with SMTP id ffacd0b85a97d-48582315a47mr5571279f8f.2.1788453691996;
        Thu, 03 Sep 2026 09:41:31 -0700 (PDT)
X-Received: by 2002:a05:6000:22c2:b0:484:3147:49c9 with SMTP id
 ffacd0b85a97d-48582315a47mr5571189f8f.2.1788453691502; Thu, 03 Sep 2026
 09:41:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831144802.834315-1-seiden@linux.ibm.com> <20260831144802.834315-24-seiden@linux.ibm.com>
 <aphMx5hsoXwIpNjt@google.com> <20260903083857.33034-B-seiden@linux.ibm.com>
 <apmHrnxRLl9BuVhn@google.com> <20260903154317.246414-A-seiden@linux.ibm.com> <apmhX8H-WUc3U4_N@google.com>
In-Reply-To: <apmhX8H-WUc3U4_N@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 3 Sep 2026 18:41:18 +0200
X-Gm-Features: AcwNN1UO9-vCqk6RvEI48oEKpR6Wrb2Fp2swzaiyckPlKKdzDRVW5sMiBpGtdhU
Message-ID: <CABgObfYUYCRtmJkh1Ns4VBbWqk3ggnDu294G9rZ6tva56=F11Q@mail.gmail.com>
Subject: Re: [PATCH v7 23/23] KVM: s390: arm64: Add KVM_S390_ARM64 Kconfig and Makefile
To: Sean Christopherson <seanjc@google.com>
Cc: Steffen Eiden <seiden@linux.ibm.com>, kvm <kvm@vger.kernel.org>, kvmarm@lists.linux.dev, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	"Kernel Mailing List, Linux" <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Grapentin <gra@linux.ibm.com>, 
	Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	David Hildenbrand <david@kernel.org>, Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>, 
	Gautam Gala <ggala@linux.ibm.com>, Hariharan Mari <hari55@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>, 
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>, Oliver Upton <oupton@kernel.org>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Il gio 3 set 2026, 18:33 Sean Christopherson <seanjc@google.com> ha scritto:
>
> How many people are running distro kernels on s390 hardware?  And how many distros
> actually change the default KVM settings, e.g. to build KVM as a module instead of
> baking it into the kernel?  My guess is "not many" and "almost none", i.e. the
> actual impact on downstream users is likely miniscule.

RHEL and SLES *are* distros, and I am not sure which bank or insurance
company would be running non-distro kernels. :) So I assume you mean
"how many people are running non-distro kernels on s390".

At least RHEL builds KVM as a module for s390x, but it's not a
problem. I agree with you that having the equivalent of INTEL/AMD, if
possible, is a desirable self-check.

Paolo

