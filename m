Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7709A3ACA4A
	for <linux-s390@vger.kernel.org>; Wed, 29 Apr 2026 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777458785; cv=none; b=gIPQGLFfx9bhNcmrDS5s6BJbjtvHXXUIkJt/+JQfvH9hwfasrwcuC90+C1b7RIY56rSTCcFcEdFDI6gpheTEkYbuTMvxiX9hlEGWSubVwVwkopqmXpwfuEQESghMy9eLfkAxqS7MXihE2sppZvoKna+nAYHmVo5FzCE9E730Xj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777458785; c=relaxed/simple;
	bh=yFhayD52z3L7U6BHgw+cudW5sbh19gSx0aS5+81Qih0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXNaF4N4oo6TUVGz8PSm5GQ5jOfMwqxrVrEr7EAjA4p38wiRz06qF9TF6VfdXyhAcd83m6pFEThNEok0k2kEFkjCVyPHfHxMXI84vOzT8fePiPfyAfIZjPpGT4uEwGoxM3bfa+ikkxkmEGnQ5C6PH7T30O1nAzUSNNC9Q5cvey4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g8BBBJkn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g8BBBJkn"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so112499045e9.0
        for <linux-s390@vger.kernel.org>; Wed, 29 Apr 2026 03:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777458783; x=1778063583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lsOPwXrH/NRDkB8GeQFymGAe4gDJjLZ8FQiVmg2qTZI=;
        b=g8BBBJknfuaqkkXqIzZ7TcTKBkDWskMBX8rFgdmqzSxOCL9QdZNstfaRE/5t/mZYB0
         pgYwv693IPdMYxjrwC5hQ9gRNrJEqzUS9HISVi02waqMKVCVT4xPgYs61V4HBoDN8V5T
         Bly+Y5z5PIgTQJufoRcGdxekKyAdoJUIQuV5K8MuHsah2W5vFt50qv2AhDdHyL+zt8qN
         LbcRq6YDhlQo4a7xdK8J8xMy4cCZoEhISvaanbYTNcoqgBErMVV1EZg63/FRmUZSNqjh
         J6JId6HXk34hac9Vz4QRdoAJ4Gkv4s0gcQfpf9HFBKPlheZTbIH0z25D+BXndpZfhKza
         H7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777458783; x=1778063583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsOPwXrH/NRDkB8GeQFymGAe4gDJjLZ8FQiVmg2qTZI=;
        b=g4nnkP6rP9AWqV/jDpeTHfsF23pa15rgV6fiyyxUafOjGvlZgx6ipex9pXy75uV9jL
         lTW5KjaN8hwTE56GiK0o2IRppz0iuVFoI/33LgIv5LudspEuWHrQ5I3sHJpQsbXJ/vcf
         wIe3R989jic7W9aGbKdwR8pycaxJRg7gGHTsFh76zN71t41yj2evKkERQD3TJ/5BqWoX
         tBnbscihheq+T8pqmpX2W6aaod18AQSz8oQAkULuPDUwKC6qiM6wFRAA1HhWVAF+7M0D
         p4QeyK11bb8qOfe3JIsbIF5Qm5RRS57jhtzINznQlYwhCqqlwLTNuw8YaHprVn9l957w
         Fzfw==
X-Forwarded-Encrypted: i=1; AFNElJ9sywZz8aiQ223ZtlSmZojVcbf46pmbOJF0YbxZzkVc/+kZ1E3XXsbAPMvpr9BrNTg5dY/GtDQBpMBt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6owZRUgkTtpgFt8eIg86F1+4hlWk25dXL1SqZfxa/NPrjq29z
	74PrDU97GXEkUhXM4WY0N+t11F2ohNaHapv2BkEJV4FOky+aj/eZkX0SesFQMQTlg8A=
X-Gm-Gg: AeBDieu4JH49dOoUYcZhE2pq6FCVrvFp12+2m7L1vbTxfLj3gahCynzEH+6q1JKga9f
	eoOs2AqqJIbUAUh9qkRN7JkgEWqQ1itKF1f+5MHIDDs4LHB71Z2TeqCFhLXCeS1v4KeaB6q4hm2
	6W8HIUGBYy6D178cFd1fdQzIWMUBlIbqxxBJNWbq+kokgeH8mKMCb24qkB8rL4+oUZtmvdYMs8b
	2tXm2p7uPEq5P6Iye3tqw0bs9z/aMLZfw1TpggUV6VgVF+UUDziHehAtkf2u1otDuo4B1X51tZ3
	e0ehQZxxHOT4dJm7vsr5zRPNSPN3rLboKjbHCfMb9s7/8cdlraFy5HcxrPpM3iA6yJMrWTQzYOP
	fWQSg6PVPwJE/YndVYjZkXjbeuAGS2N+VHbFLlLliVFRWv+BA/bdrF+2YfGce1YiI7fGaQRoWB5
	2QBG/FgkRTtyzpt9slCCfzH4YVIQi3dCM1UqADrmIksh6VOGI=
X-Received: by 2002:a05:600c:19d3:b0:488:904b:f31 with SMTP id 5b1f17b1804b1-48a77b240aamr106838355e9.22.1777458782854;
        Wed, 29 Apr 2026 03:33:02 -0700 (PDT)
Received: from localhost (109-81-86-177.rct.o2.cz. [109.81.86.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7c5d2919sm43817595e9.15.2026.04.29.03.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 03:33:02 -0700 (PDT)
Date: Wed, 29 Apr 2026 12:33:01 +0200
From: Michal Hocko <mhocko@suse.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org,
	hca@linux.ibm.com, linux-s390@vger.kernel.org, brauner@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	timmurray@google.com, "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH v1 2/3] mm: process_mrelease: skip LRU movement for
 exclusive file folios
Message-ID: <afHeXY-yeTwmURWh@tiehlicka>
References: <7c7da8ae-cd39-4edf-b94f-c79ab85df456@kernel.org>
 <aevBRh08X4UTMUj9@google.com>
 <ae8NT0tLt7eBmH6j@tiehlicka>
 <CAJuCfpHQdA7C50V2WjNrdYcp7feV5ukgxJf+vMNEcp0P1SGEow@mail.gmail.com>
 <ae-Zu-VAzAA7SdLa@tiehlicka>
 <ae_roPR64e6sY_fN@google.com>
 <afBaJLLFigkdszov@tiehlicka>
 <afFco71vwmpQy3pk@google.com>
 <afG-4hq7Hr62Uu6J@tiehlicka>
 <7f98f461-62a7-455d-a7a8-cb8928465946@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f98f461-62a7-455d-a7a8-cb8928465946@kernel.org>

On Wed 29-04-26 11:09:55, David Hildenbrand wrote:
> Unrelated stupid question: would things be clearer if we could rename
> MMF_UNSTABLE to MMF_OOM_REAPING once figure out whether aborting fork() still
> really needs it?

While the oom is the only current kernel user of MMF_UNSTABLE (in a
sense it sets the flag) the flag should denote that any page faults are
reliable because it might fault in a fresh memory and user would lose
the previous content without knowing that. Not sure MMF_OOM_REAPING
would reflect that reality better.
-- 
Michal Hocko
SUSE Labs
