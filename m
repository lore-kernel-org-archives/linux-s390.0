Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24009 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726333AbgD3REW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 30 Apr 2020 13:04:22 -0400
Subject: Re: [PATCH v2 6/9] s390/module: Use s390_kernel_write() for late
 relocations
References: <cover.1587131959.git.jpoimboe@redhat.com>
 <18266eb2c2c9a2ce0033426837d89dcb363a85d3.1587131959.git.jpoimboe@redhat.com>
 <20200422164037.7edd21ea@thinkpad> <20200422172126.743908f5@thinkpad>
 <20200422194605.n77t2wtx5fomxpyd@treble> <20200423141834.234ed0bc@thinkpad>
 <alpine.LSU.2.21.2004231513250.6520@pobox.suse.cz>
 <20200423141228.sjvnxwdqlzoyqdwg@treble>
 <20200423181030.b5mircvgc7zmqacr@treble> <20200430143821.GA10092@redhat.com>
 <20200430164842.bvkrh5fz24ro7ye2@treble>
From: Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <691690e3-b792-bac5-2080-2abfc0beb11b@redhat.com>
Date: Thu, 30 Apr 2020 13:04:10 -0400
MIME-Version: 1.0
In-Reply-To: <20200430164842.bvkrh5fz24ro7ye2@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Miroslav Benes <mbenes@suse.cz>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jessica Yu <jeyu@kernel.org>, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, Vasily Gorbik <gor@linux.ibm.com>

On 4/30/20 12:48 PM, Josh Poimboeuf wrote:
> On Thu, Apr 30, 2020 at 10:38:21AM -0400, Joe Lawrence wrote:
>> On Thu, Apr 23, 2020 at 01:10:30PM -0500, Josh Poimboeuf wrote:
>> This is more of note for the future, but when/if we add livepatch
>> support on arm64 we'll need to make the very same adjustment there as
>> well.  See the following pattern:
>>
>> arch/arm64/kernel/module.c:
>>
>>    reloc_insn_movw()
>>    reloc_insn_imm()
>>    reloc_insn_adrp()
>>
>>      *place = cpu_to_le32(insn);
>>
>> maybe something like aarch64_insn_patch_text_nosync() could be used
>> there, I dunno. (It looks like ftrace and jump_labels are using that
>> interface.)
>>
>> This is outside the scope of the patchset, but I thought I'd mention it
>> as I was curious to see how other arches were currently handling their
>> relocation updates.
> 
> True... I suspect your klp-convert selftests will catch that?
> 

Indeed.  Actually I had hacked enough livepatch code support on ARM to 
see what happened when converting and loading the test patches :)

-- Joe
