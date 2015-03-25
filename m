Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5512C96D.80803@suse.cz>
Date: Wed, 25 Mar 2015 15:42:53 +0100
From: Jiri Slaby <jslaby@suse.cz>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/1] livepatch: add support on s390
References: <20150324150437.GB24424@treble.redhat.com> <1427215860-13607-1-git-send-email-jslaby@suse.cz> <20150325125705.GD11885@treble.redhat.com>
In-Reply-To: <20150325125705.GD11885@treble.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: jkosina@suse.cz, sjenning@redhat.com, vojtech@suse.cz, live-patching@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 03/25/2015, 01:57 PM, Josh Poimboeuf wrote:
>> +#ifdef CONFIG_LIVEPATCH
>> +static inline int klp_check_compiler_support(void)
>> +{
>> +	return 1;
>> +}
> 
> This should actually return 0 on success.

Deja vu as I fixed this once already. Let me runtime test the patch
before I send it in the next round again.

thanks for spotting,
-- 
js
suse labs
