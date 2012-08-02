Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 2 Aug 2012 14:41:57 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2] [S390] do not clobber personality flags in
 sys_32_personality()
Message-ID: <20120802124157.GA5742@osiris.boeblingen.de.ibm.com>
References: <alpine.LNX.2.00.1208012045500.14910@pobox.suse.cz>
 <alpine.LNX.2.00.1208020910260.14910@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1208020910260.14910@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Jiri Kosina <jkosina@suse.cz>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Aug 02, 2012 at 09:11:23AM +0200, Jiri Kosina wrote:
> There are multiple errors in how sys_32_personality() handles personality
> flags stored in top three bytes.
> 
> - directly comparing current->personality against PER_LINUX32 doesn't work
>   in cases when any of the personality flags stored in the top three bytes
>   are used.
> - directly forcefully setting personality to PER_LINUX32 or PER_LINUX
>   discards any flags stored in the top three bytes
> 
> Fix the first one by properly using personality() macro to compare only
> PER_MASK bytes.
> Fix the second one by setting only the bits that should be set, instead of
> overwriting the whole value.

Applied. Thanks!
