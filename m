Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF991E480
	for <linux-s390@vger.kernel.org>; Wed,  9 Oct 2024 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728479292; cv=none; b=JsVRjdV3VzM27OVudzRdNxu3MNwTh/Lkdqe6AA4KuZnzLAq3ljtzXEsuKZI9KQiAgprJvR39sSHu+a5Ri/LhkzTsGduyGTadbgr6tLowkGlpL6jd/NhZX59m72Sx1IccxtsFCOqeuiYLZlDkh+FmJKQG+sUTslGa/bsSM2sfzag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728479292; c=relaxed/simple;
	bh=vCQMT4/OGh33l5VSSGRJ9d7C/T789iko1vgWGYbPl3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bx4I2vuAsmNYeTLVobVQMZ7g5e82COagxSVC4ZxkrEicx6IfNbkcgi/A8YC5BkGly3hcc+q5TIJYthOZ59PbGUqg12rf07Ade3JpLz5RpIEHzLqh4Z+Di9OMFJLLiAEVnrYW2wvAtMwXgXh/MjrCVNC0toevEjWP45vyN3sB7cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i6Ev8wWy; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i6Ev8wWy"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c40aea5c40so1730453a12.0
        for <linux-s390@vger.kernel.org>; Wed, 09 Oct 2024 06:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728479289; x=1729084089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCQMT4/OGh33l5VSSGRJ9d7C/T789iko1vgWGYbPl3c=;
        b=i6Ev8wWyrJJ0Yl0c1tbvd5CmJHJjJWPTrfBJb1pGNFjIepCCc7/a8hDS7cnDANcLP4
         HfExdkHtbZOImNku/VdHtl70314hhzYL/2FOeiUswb/7LNWofZ0Zes7g3YGn6CkvGKwo
         auzUAv6CswEdvouXHjR+60F7cUH06Rri5UWzKLJKu8IrzhtQFRB3WVWueJt666buz9Bm
         t/paGayUYqTD6Uxc9Zvl7dEOKqxa94w2UxrKno7377DrMNYdEL0QK1gBSXIiDMZ6bGED
         48fq921UWwAcnDG9+8u7WjgfKj+Hcn1GKAwE4CyGlkyAr7sdUVNzjAPkC73xm30zCYou
         i9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728479289; x=1729084089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vCQMT4/OGh33l5VSSGRJ9d7C/T789iko1vgWGYbPl3c=;
        b=J3iOSCp/P+O1QsBVqDC1T1Ko57t/rDWELzHqOnRad25PAFUm2yWf2D4ZrX31Fxbcpf
         mMDovVqYijjIKRs5OBNL1oasy6DxRSxbc5R6Sr6lyL11khBdfK6QE/w6gyWSv+lE5a0E
         37M0Ud601IWNTkV/gK3r39uHrfBx5XvFzC5Pd9TBPmDVZ3bwyTPvXAJBrWuZ4xp4zraP
         wpMe/RQq1y/Deaau4HFVL4OWT/iS7ebrG7tc6GyN0O816kyMdsYG425QBR30YGvnb15B
         ZdVEUjz7xevTXYhhzW53luHa7czAz+7zZz0NBrXR3Ffpt6BSNzMlEItQaKHwmCW6ZSo0
         J57Q==
X-Forwarded-Encrypted: i=1; AJvYcCX4wbWJ+eXA5ZtluaGoi5bMSD3cbdy6mNA9W+AahLVoh8Wast3KAtQEKYlm0gk4uTpQ/A0gOqYO9cPg@vger.kernel.org
X-Gm-Message-State: AOJu0YySRxJixqAAO02bGqo8tzsvm4VO614lJi4eqpBr5l1ekNnIK4p7
	AH0GRRL0F123mSjEuZ5KusVGVH26dfbY8+AyJXJA50EFZXclfALfp++LMppBqBYZPyZ8pSZMieN
	kZFh7dFxCOgGQOAwfDu/uH173QhseOn4xyIS7
X-Google-Smtp-Source: AGHT+IFwK3xKFaDSSCvmmCWjZJRLZHvuDOCWYPKnAPbZzhaE0XDUbBsW+cRSZvarCC5CcONpOhTI9Gbt8lX1yJczGgs=
X-Received: by 2002:a05:6402:26cd:b0:5c5:c444:4e3a with SMTP id
 4fb4d7f45d1cf-5c91ce41ba7mr2845945a12.0.1728479288868; Wed, 09 Oct 2024
 06:08:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1728456916-67035-1-git-send-email-alibuda@linux.alibaba.com>
In-Reply-To: <1728456916-67035-1-git-send-email-alibuda@linux.alibaba.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 9 Oct 2024 15:07:54 +0200
Message-ID: <CANn89iLHwsKVQo_aVwVQAt3fpZ2E3SL3eM2-v+RacwbOdUqePg@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: fix lacks of icsk_syn_mss with IPPROTO_SMC
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, 
	wintera@linux.ibm.com, guwen@linux.alibaba.com, kuba@kernel.org, 
	davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-rdma@vger.kernel.org, tonylu@linux.alibaba.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 8:55=E2=80=AFAM D. Wythe <alibuda@linux.alibaba.com>=
 wrote:
>
> From: "D. Wythe" <alibuda@linux.alibaba.com>
>
> Eric report a panic on IPPROTO_SMC, and give the facts
> that when INET_PROTOSW_ICSK was set, icsk->icsk_sync_mss must be set too.
>
>

> This patch add a toy implementation that performs a simple return to
> prevent such panic. This is because MSS can be set in sock_create_kern
> or smc_setsockopt, similar to how it's done in AF_SMC. However, for
> AF_SMC, there is currently no way to synchronize MSS within
> __sys_connect_file. This toy implementation lays the groundwork for us
> to support such feature for IPPROTO_SMC in the future.
>
> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
