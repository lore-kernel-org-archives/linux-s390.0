From: Steffen Maier <maier@linux.vnet.ibm.com>
Subject: Re: [PATCH RESEND 3/3] zfcp: remove access control tables interface
 (keep sysfs files)
Date: Thu, 22 Aug 2013 18:40:56 +0200
Message-ID: <52163F18.2020109@linux.vnet.ibm.com>
References: <1377099366.2011.23.camel@dabdike.int.hansenpartnership.com> <1377186338-35344-1-git-send-email-maier@linux.vnet.ibm.com> <1377186338-35344-4-git-send-email-maier@linux.vnet.ibm.com> <1377189037.2009.14.camel@dabdike.int.hansenpartnership.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1377189037.2009.14.camel@dabdike.int.hansenpartnership.com>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Peschke <mpeschke@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 08/22/2013 06:30 PM, James Bottomley wrote:
> On Thu, 2013-08-22 at 17:45 +0200, Steffen Maier wrote:
>> From: Martin Peschke <mpeschke@linux.vnet.ibm.com>
>>
>> By popular demand, this patch brings back a couple of sysfs attribut=
es
>> removed by commit 663e0890e31cb85f0cca5ac1faaee0d2d52880b5
>> "[SCSI] zfcp: remove access control tables interface".
>> The content has been irrelevant for years, but the files must be
>> there forever for whatever user space tools that may rely on them.
>>
>> Since these files always return a constant value, a new stripped
>> down show-macro was required. Otherwise build warnings would have
>> been introduced.
>>
>> Signed-off-by: Martin Peschke <mpeschke@linux.vnet.ibm.com>
>> Cc: stable@vger.kernel.org #3.11+
>
> If I'm sending this for 3.11-rc, this stable tag is unnecessary, righ=
t?
> It will go into 3.11 and you don't want it for 3.10.

Correct, it's a no-op, my bad.

--=20
Mit freundlichen Gr=FC=DFen / Kind regards
Steffen Maier

Linux on System z Development

IBM Deutschland Research & Development GmbH
Vorsitzende des Aufsichtsrats: Martina Koederitz
Geschaeftsfuehrung: Dirk Wittkopp
Sitz der Gesellschaft: Boeblingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

--
To unsubscribe from this list: send the line "unsubscribe linux-scsi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
