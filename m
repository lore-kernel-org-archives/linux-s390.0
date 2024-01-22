Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9E43A1CF
	for <linux-s390@vger.kernel.org>; Mon, 22 Jan 2024 12:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705928117; cv=none; b=KnWHffdLmiCniJYNv3/kVa/zWcXGXh4tr3UTQBa/+baRo7zQSDXo/mD+Fa3cjlS3mtdNvz5/WZ/4FgrHREWvrKGe8tWYuCgLEMihexaEleNfR+/T7uJHwLXJjClZ+yCZk93A2jH+LRUBOvj8PbHK7uEiFBnsp2xeMb3aJ870kOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705928117; c=relaxed/simple;
	bh=v+L7PVTpZDw0rKx6LNXPOAvhzXFGb5VQm0BCqFUAkRQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IW991bS+yoFNxkqL0BdO6If2ZTGg50LYj21io9t4DRBCr4DazZJHvY8G5ierLRDos/h6ZJaX1lAiUS/MLST8jxtJ+9lJizIbWBTjHzjAk5jIx2zqzC+9hdMFlCqR8NPv845mPkcPidRvac6a5gjcRlaj5dUGImblEFDM6A1J9bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SQl/V1bc; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SQl/V1bc"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55c6bc3dd54so62820a12.1
        for <linux-s390@vger.kernel.org>; Mon, 22 Jan 2024 04:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1705928112; x=1706532912; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IuUKVWtvvYIXVeVdCt3DqjuZg1hGyra7osExMMOSS2E=;
        b=SQl/V1bcIuhJ5oVnf9KbTKasKw/Xc9CFzbh4SxN5CjzJDNDyaaY7llm9PPRgzR6u9F
         OHV9I+5WhAMPolI5Ks8oBWlKTDa8gjb7M9JjQ2GD5/j8+Q02z0QUpLTae3EtL0rR60Ni
         uRxndjWKzk+5iv8yzMlciuJ7hLrbKp3P8Mn2Eif7I1Dok5xbHJ4YDIywdyWj87n1TKJb
         EqiGacj03JUOdgJlBgTbfxnH2qNueapOZqAM1eEL60M8r250R94FwiwsdvrTqr9XPJiI
         pHTO8Nz8MvAl2F+2jxO4C2VJW0A7tQ/Hm/2hZOoXgkmrkw0Uu8xpRCbbT+uVHSKx7xyq
         szVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705928112; x=1706532912;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IuUKVWtvvYIXVeVdCt3DqjuZg1hGyra7osExMMOSS2E=;
        b=EXj3GNm6BG0f7mc8PzocXqAc3zKEWOwSGiJbB9Qrw6El3Hed6ApibwR3/A7RS91FKM
         OViyeWhx+6EoCc749qFLUzfYYyMRRf4d+KaecvmITfhAki8zAt/Vpwzf0RyVGh3xJjkp
         L0hpyYVrId/VeZas5fsAcaxY6SK8qp4LfdaBZAOEHawKPi2UrphV5IxRhR/PJ1ahFS5p
         KavTB0Dw8eRF2UKdZbc3I91BI4zlqUAUSbqtY3iQDnuXEraB1pvHx2NPvTlzga/P7LCx
         JlHXqc6rRQiqNRWekPAz4qi4B+eICSww1rJj/7X7GuTiS8dJOB7lGq1H3j8ZiZnk9Q9d
         a3RA==
X-Gm-Message-State: AOJu0Ywdh3MQqPDKzqfSQQ4MvCH2z6RXIARAul3QnTAAn/OQR8EFjVhD
	rMUkkWvN3fpVewbk3vuPIYDnb1Wpj1AgQsNVxwC9015LEckeYbxI4yGckaNTcjs=
X-Google-Smtp-Source: AGHT+IFMwp2rvA2TkeKR8EEYT9ihnqdp0q0BkNQSHFUaT5nh8UK+VHg2raGKecMA0Ym1+fdVY83xQA==
X-Received: by 2002:a17:907:778c:b0:a2f:6053:2ab7 with SMTP id ky12-20020a170907778c00b00a2f60532ab7mr5368477ejc.11.1705928112494;
        Mon, 22 Jan 2024 04:55:12 -0800 (PST)
Received: from ?IPv6:2804:30c:974:ac00:1b02:e2fd:23be:79bc? ([2804:30c:974:ac00:1b02:e2fd:23be:79bc])
        by smtp.gmail.com with ESMTPSA id g10-20020a92cdaa000000b00361b87d1645sm1526721ild.54.2024.01.22.04.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 04:55:12 -0800 (PST)
Message-ID: <53cf93b2efadc0f42712eb92436bd575b5622664.camel@suse.com>
Subject: Re: [PATCH v6 2/3] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
From: Marcos Paulo de Souza <mpdesouza@suse.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Heiko
 Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina
 <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,  Petr Mladek
 <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 linux-kselftest@vger.kernel.org,  linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-s390@vger.kernel.org,
 live-patching@vger.kernel.org
Date: Mon, 22 Jan 2024 09:55:06 -0300
In-Reply-To: <Zap26MINbbxREt4c@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240112-send-lp-kselftests-v6-0-79f3e9a46717@suse.com>
	 <20240112-send-lp-kselftests-v6-2-79f3e9a46717@suse.com>
	 <Zap04ddls7ZvbL/U@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
	 <Zap26MINbbxREt4c@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-19 at 14:19 +0100, Alexander Gordeev wrote:
> On Fri, Jan 19, 2024 at 02:11:01PM +0100, Alexander Gordeev wrote:
> > FWIW, for s390 part:
> >=20
> > Alexander Gordeev <agordeev@linux.ibm.com>
>=20
> Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thanks Alexandre and Joe for testing and supporting the change.

Shuah, now that the issue found by that Joe was fixed, do you think the
change is ready to be merged? The patches were reviewed by three
different people already, and I don't know what else can be missing at
this point.

Thanks,
  Marcos


