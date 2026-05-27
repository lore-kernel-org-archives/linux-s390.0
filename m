Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6651B78F3
	for <linux-s390@vger.kernel.org>; Wed, 27 May 2026 05:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779861482; cv=none; b=pY5i92V3dV7sCP4oP0In+jHQxBaK5Nj40SLw0Q3I6QC8hZMezQOo2wRN+HGoSlH9TzX+QtKbTRv8VfLu1ztmZEOijzHKcied5UgMhQhJ7Gd+sydy5zhzJpuTyAtCQSgzqM0kx3DzyVABueaL1MXt1hMQU6yroU4ZXLFZ/2r7wv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779861482; c=relaxed/simple;
	bh=Ds858C8JSlwFv9V0HFpdGWu5Lwj48IBa8qLqXCeXhAY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SnWtkWsPY8Oddy06Pzg7rPyjqnpYy1YIPfeu6uYLn/s5HZ8IzDFHlZVJhkmTnwcY+5DSxyy4Q+nymvqAuYEEvWSCEe0Dbhyd+NWhAF09RbNiauJ/zerMboAYpYCpGGdgMrtBYzKg9kdP9tv54SleFr4lJeYk3MJT1qNYoWNRyCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BlOmG/n3; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BlOmG/n3"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-48d127eb013so54125955e9.1
        for <linux-s390@vger.kernel.org>; Tue, 26 May 2026 22:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779861479; x=1780466279; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QL+f4AZjX4KECcd9eray4sdH5Ebp4GC/Yod4j5/Zhjg=;
        b=BlOmG/n3CW7KU+Owp2zMH4yWG3mALcdjcy4JFYNgcC6JHWYsJh6O5hrh9WfP35W0k/
         JiaOywqLFv07Iz0r+BY297tnyHUio885FaRJ5T/xOzUo/qyN2lc7cjMWci5DW9bEo3Yc
         QBhbHvWmbXhozaY6Q2eRJVY4TYWraZciyhzc9dGq4Si3UKtthpKj2PKeqIAzGjN4t42q
         dce77sT6/MUyME0ZmQSVi4m263rzW+2mTJO3Ja71ozbliQRjQ+/ixPyn/zYPEAObi4RP
         iekk1l+tpeI6qbHxjrk3K1YAQGSioCFILF/ynVbGJnI/hFRBvF4Pi/kFfxv9OcQ5cBYG
         idzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779861479; x=1780466279;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QL+f4AZjX4KECcd9eray4sdH5Ebp4GC/Yod4j5/Zhjg=;
        b=TWzIi4BZOSxVBtp7aSq/+o79tufLO1EQkdQ4wuT7b87gPWKMYd8IxDMrbbJZbKNHrN
         HlZh5oWF4Y142x+81lZVJX28PwcnIaezQhfA5EMV6BeOTT45pU3j3Yawu1aeLcJgLzNW
         TWDHdOBcIeGP0G3EWrzfpU8gcW3kSQUqYDr+5mAK43pmPcsdlEWyCNiNPuwyhtAAtsZx
         DoFu1Tb9bumWUs3i5eYe6CP+xMwb3WIQoJ+CxIUa8/1Y+Zl+hRTZb3Yd5Lp2suU+8w/t
         P8XsaBwlSn6pXh2T7pLlxA8WGI2g6z7QmtSkt8nOezWzm1Y4D58FrSqUqTGzsRsT/ryp
         2H4w==
X-Forwarded-Encrypted: i=1; AFNElJ/tVu0cNiTJW2q7DV+HOkjLDR/jHO56TCjBNk6Xrwgbgctz3fcvmeNgXsnZnO/gXx8UB/MZdxGD6Mwt@vger.kernel.org
X-Gm-Message-State: AOJu0YxvdL3R3tXdxgjQmju9jshhE8BLD/dnRFU8Hl+5Og2mqrpsc/u/
	MepEXMuceilLsQZPKhpfmVIe2VD6Uoxjt0j3YTqTPAnV+98/gtk3SX81ikr7Lb9vcMreGitF7tj
	BsEf1dWYmbA2SB6nP/g==
X-Received: from wmql4.prod.google.com ([2002:a05:600c:4f04:b0:490:3c15:7144])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c168:b0:48a:6798:52e9 with SMTP id 5b1f17b1804b1-49042268d98mr377878395e9.0.1779861479469;
 Tue, 26 May 2026 22:57:59 -0700 (PDT)
Date: Wed, 27 May 2026 05:57:58 +0000
In-Reply-To: <20260521165622.279953-3-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260521165622.279953-1-japo@linux.ibm.com> <20260521165622.279953-3-japo@linux.ibm.com>
Message-ID: <ahaH5k0yKi9IFvv8@google.com>
Subject: Re: [PATCH v3 2/4] s390/jump_label: Implement ARCH_STATIC_BRANCH_JUMP_ASM
 and ARCH_STATIC_BRANCH_ASM macros
From: Alice Ryhl <aliceryhl@google.com>
To: Jan Polensky <japo@linux.ibm.com>
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	ojeda@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, 
	jbaron@akamai.com, borntraeger@linux.ibm.com, svens@linux.ibm.com, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, 
	rostedt@goodmis.org, ardb@kernel.org, linux-s390@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, May 21, 2026 at 06:56:20PM +0200, Jan Polensky wrote:
> Rust static branch support needs the s390 jump label instruction sequence
> and __jump_table emission in a reusable form. The current implementation
> embeds the sequence directly in the C asm goto blocks, which cannot be
> shared with Rust.
> 
> Introduce ARCH_STATIC_BRANCH_ASM and ARCH_STATIC_BRANCH_JUMP_ASM to
> describe the brcl sequences for the likely-false and likely-true cases
> and to emit the same __jump_table entries as before. Switch the existing
> C helpers to use the new macros to avoid duplication without changing
> the generated code.
> 
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>

This looks right.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Did you test it?

Alice
