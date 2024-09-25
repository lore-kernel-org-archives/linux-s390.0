Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EE61D5ADC
	for <linux-s390@vger.kernel.org>; Wed, 25 Sep 2024 18:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727290233; cv=none; b=VHfP2tX0Ah8irVunzeC6tMHKb6sR7sjSAPncLU+IuWF4VgEekZbpWj/rGTCIQcN2LArTEHkQVt4ek1h7FZzWfvzQfAaDqbuu5TBFNk/eMceWicfcVqZRpd7MzTSyDXPMkAxh93PeNuXERL5DzoYv1rkhIW7MqGGYd5HavNLZofU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727290233; c=relaxed/simple;
	bh=Z7kWssl4XZPaLL+5nUhmnGIgZllP/Q/flkFj3v+9mLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qqykbYrmFB5U1FQREaJWYIUtATBE5tdgwSXa0fwtPuGbDYk2Gh6/G5Pr9gY1X67j5nkFQe5B5EzYDWahqBg99ptghjp7hC26L3Dtrhh2Hjh2OGK2f116E9zWzTgh3QmJaLrh8FCxOsmjymCfP9jlkYVnf8SzU+eBboe+HsevIuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OqEC9Ig6; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OqEC9Ig6"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53660856a21so183936e87.2
        for <linux-s390@vger.kernel.org>; Wed, 25 Sep 2024 11:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727290228; x=1727895028; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uh0JQMZG3vWViuegY3eLz6gtbb6ALA7V+/Vd0bHsYGk=;
        b=OqEC9Ig6nqjsQx59lTRlf8qYQsIuZMj13cAXxQuk6k6Czi8qnVPs0udjcZ4UMU28ae
         s435xMJ6ljE99S5dsqB8EOLnXPWWxDqWuTyxKj79XKk8mal5A+uQdtkVWAsEhEPbJJm5
         yytXmKa3pDtOKuLNuWpSkjAYtzetE8lHV7fA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727290228; x=1727895028;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uh0JQMZG3vWViuegY3eLz6gtbb6ALA7V+/Vd0bHsYGk=;
        b=Bu8BBmIKCc2dCyUfBRHtTVmQ+gTyFLIRw4eJVHooiKr6r+f2Cb1Z5gle9ir6Lu8uqv
         E27kfgxnBKKHksm9la3R9JwmXtw8/YXgS4LpVOiqp8u1pDhdwZtmsuRQWfKhkzbEY3ui
         LNS19EXab4fSZu4jjh1sGM/4oeh350iGz03vIUczElsvxcZk5dTXb3oDhlE8uHoKbAsL
         Pn2oFPgLW6O0gcogxEOYMQRsAREhP/1Qh3PXi/bPhQsoBbr8zWdnEyEAI5D3TPjSCC7u
         Dua631638Cg2Xe6sWiTJC34c8eLlitM5uqgKp1qzJv6m6gtCmkOhm18AiDVdCEsokMPb
         hNmg==
X-Forwarded-Encrypted: i=1; AJvYcCVk3blzFbVK3fgs9dTQusr6eiMtvrqema/iWA4iL6LQGurgrrztq/V2+25zJhUw/z0i9ZOix3KbahQa@vger.kernel.org
X-Gm-Message-State: AOJu0YwJo+Zuhd/5LnsAH7H1Ah0oKIQJCJU9LD1vT8jvFZuSH4wp8RMF
	ttHY+lkihToFkelWiSjCe2YApd7Fl0etpxcgT6nWQWeUZnzEBSrUA6pDwOkqUiVlSGy4UdEHeYh
	/BI2faQ==
X-Google-Smtp-Source: AGHT+IELwR/1O+KnZBajqhXKUfj+Mg6TtO9A6neWA5bmcnt9WsWyZI8485gW1wmCU+OccN/2oxwaTw==
X-Received: by 2002:a05:6512:3c9c:b0:536:7a24:8e89 with SMTP id 2adb3069b0e04-538775679dfmr2296463e87.49.1727290228386;
        Wed, 25 Sep 2024 11:50:28 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a85e1054sm591448e87.7.2024.09.25.11.50.27
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 11:50:27 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5369f1c7cb8so250615e87.1
        for <linux-s390@vger.kernel.org>; Wed, 25 Sep 2024 11:50:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRWJXKZTwqeUVhN2+fwTuprN4X6xJW0MTndoIXps7uPMxICGFNi8TdwtxalFOiHoCzvQWFldVneASp@vger.kernel.org
X-Received: by 2002:a05:6512:e89:b0:535:665f:cfc0 with SMTP id
 2adb3069b0e04-53877533876mr2498473e87.32.1727290227263; Wed, 25 Sep 2024
 11:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923063707.40017-1-rppt@kernel.org>
In-Reply-To: <20240923063707.40017-1-rppt@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 25 Sep 2024 11:50:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=8JhAWjaxZPEOQgarTTsqPV0AQO=Q0USYtG009EYhUA@mail.gmail.com>
Message-ID: <CAHk-=wh=8JhAWjaxZPEOQgarTTsqPV0AQO=Q0USYtG009EYhUA@mail.gmail.com>
Subject: Re: memblock: updates for 6.12-rc1
To: Mike Rapoport <rppt@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Oleg Nesterov <oleg@redhat.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Wei Yang <richard.weiyang@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 22 Sept 2024 at 23:37, Mike Rapoport <rppt@kernel.org> wrote:
>
> memblock: updates for 6.12-rc1

Please make sure that there is a "git pull" somewhere in your pull request.

Now, the "git" part will always be there from a git request-pull (as
part of the "are available in the Git repository at" string), but I do
want to see a "pull" somewhere too. Otherwise my search functions
don't light up the email, and then it takes me longer to notice.

Most people put "[GIT PULL]" in the subject line, since that's also
how you get the attention of the pr-tracker-bot. So that's the
suggested way to do it, even if my search functionality is a lot more
permissive and just wants to see "git" and "pull" _somewhere_ in the
email.

You have done that in the past, I'm not sure why it didn't happen this time.

               Linus
