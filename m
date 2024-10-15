Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9455E1B0F1B;
	Tue, 15 Oct 2024 22:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032511; cv=none; b=sSmnLw5U7HN2MkKwyjQHdc8MymvbKfOSa4v4Z66u/diU9eqyj5htzkImNdL+xJYyU1x7MPCHH55ig7viM8pvfi8xfS4OrIMQXpm88VY4HIVWYUuyEMHeGBexOwmHfsNwuNliXG4mivq6qvdILP+1Lk1Z2qx3nV8dDD/MZu/1r60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032511; c=relaxed/simple;
	bh=FyiHtAVvTzCEkj0V3+7gyURY1cc8IYk4SenxCNrmAIk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iaTUbUI1jTGabClO7HLuT5E6tLpBTF6wMfD9CbbRPj/+/nzSXdLTmz5ALn/MXSuFkb5kujTV0faEVaYieTXNWnt72wVvdSHZgW2IhEhriz6hB88vh2oDMgMQTySJdpQeP0tSsXQOqIeYtbC8dHpLgvwdFugW6gRtMMDDcjzCiWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8H2/Yf2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8H2/Yf2"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20c6f492d2dso66123335ad.0;
        Tue, 15 Oct 2024 15:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729032509; x=1729637309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XMBXGuDQgMrnZyPJNJoyS2+8yVGGtiTTAq3h4RC/wK8=;
        b=F8H2/Yf21sY5PC9IiCoYmSrHu73n+y3r5nczKEpsLqLFSxUm+RBD02OhgiVZC90qnS
         3g3u4cOIglFBkY84F4Wud1UECUB1GV740xIvSCYURAub6hh/92pSYzNXcAnV8NUsNUkG
         RCtREB4oumR9+1XK86/HFn0IXox8+BBcT3UORi9FPlRHZH4eZoaBs+E0KV9vy8zRPlJh
         ByMAbfC7KI6avXp6meD2tivXGy3Qe7nJAX4TRUyUsG/A48ok+HaU3ruiS7H72wSRk4SP
         huW5Yg4T6m0Q8BbGTkQhBLtgStnuan+8dq987hGgAJVrFpEa0gjSVgUNdJIlfz1Me3wR
         k73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729032509; x=1729637309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XMBXGuDQgMrnZyPJNJoyS2+8yVGGtiTTAq3h4RC/wK8=;
        b=sZXdoKmpXXDkps+ydGJp+XPGK0iJIIya9p66I+AgIXg4NAtsOKerPQ3Xvj7KmNrIEO
         O/9YhdnSBonKWOGMESXD+3ymysyr26JxER9ls62G5ude/6kZeraewuZhCcxMLSZOqS+s
         WSm5DH2m3lEw5J/iwEO8gBAivZFwqXnpaT9jRz1Z7Fma09M6V4F/71jwgRuphwZ98lI3
         XVtim6EqaIujocVGZ+7eorCi11KiQEWRvWrQOXdPNoBvKFUngizHKBnV3mDJi9syiJs2
         8is4J3ABWtCQ8mlAUZfIPg+Dh42ugTtqctqiYKUqWANZMB/lkK9cXhqx0Tja8veK5URs
         tBZA==
X-Forwarded-Encrypted: i=1; AJvYcCUIVAVivvm32irDLAydqFANu+vWwX5Lvl7LIY/OgkkjL9fUjXnehJ04IwXBM2XqhwUUPQemuLdl2TLPkA==@vger.kernel.org, AJvYcCV/w/FtyevFSPYxJAyVp2RPHrxJt6z/4z3eQ7x8W3+LmxnygE82J9mNeY1MaJZKldgCN4MZhJO6ienMACQ=@vger.kernel.org, AJvYcCWUqPH1OGbpwGbbXW3NRIknz+ACrJL0zk+MZ+z+PiVo66Hw980EXcIEVYRfjLHcThODxkvR61hH@vger.kernel.org
X-Gm-Message-State: AOJu0YwOHK+xJGJu8IyctRxyHiXrK4ShQDU2kOfKX1qhuJ3cnbGracYe
	fnvh35U1fU5NUgWh9hvY3G0IJF3EOHsfvvOehsQ9jFZSwOyPazAZ
X-Google-Smtp-Source: AGHT+IEGXm0WE3tI4661kIpP6F4FzwVlt7SFNDfuIGirv0BD01dFvjYEW1LQh7zxhBhF8hiPc/Fs5g==
X-Received: by 2002:a17:902:e547:b0:207:6fd:57d5 with SMTP id d9443c01a7336-20cbb236be8mr197038765ad.36.1729032508881;
        Tue, 15 Oct 2024 15:48:28 -0700 (PDT)
Received: from debian.resnet.ucla.edu (s-169-232-97-87.resnet.ucla.edu. [169.232.97.87])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20d180366fdsm17205465ad.128.2024.10.15.15.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 15:48:28 -0700 (PDT)
From: Daniel Yang <danielyangkang@gmail.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: danielyangkang@gmail.com
Subject: 
Date: Tue, 15 Oct 2024 15:48:03 -0700
Message-Id: <cover.1729031472.git.danielyangkang@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Date: Tue, 15 Oct 2024 15:31:12 -0700
Subject: [PATCH v3 0/2 RESEND] resolve gtp possible deadlock warning

Fixes deadlock described in this bug:
https://syzkaller.appspot.com/bug?extid=e953a8f3071f5c0a28fd.
Specific crash report here:
https://syzkaller.appspot.com/text?tag=CrashReport&x=14670e07980000.

This bug is a false positive lockdep warning since gtp and smc use
completely different socket protocols.

Lockdep thinks that lock_sock() in smc will deadlock with gtp's
lock_sock() acquisition.

Adding lockdep annotations on smc socket creation prevents these false
positives.

Daniel Yang (2):
  Patch from D. Wythe <alibuda@linux.alibaba.com>
  Move lockdep annotation to separate function for readability.

 net/smc/smc_inet.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

-- 
2.39.2

