From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Wed, 19 Aug 2015 07:43:46 +0000
Subject: Re: linux-4.2-rc7/drivers/s390/block/dcssblk.c: 3 * bad array index ?
Message-Id: <20150819094346.1150dba4@mschwide>
In-Reply-To: <DUB128-W11065573F4730A28DBF59A9C670@phx.gbl>
References: <DUB128-W11065573F4730A28DBF59A9C670@phx.gbl>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 19 Aug 2015 07:30:58 +0000
David Binderman <dcb314@hotmail.com> wrote:

> 1.
> 
> [linux-4.2-rc7/drivers/s390/block/dcssblk.c:553]: (style) Array index 'j' is used before limits check.
> 
> Source code is
> 
> ������� for (j = i; (buf[j] != ':') &&
> ����������� (buf[j] != '\0') &&
> ����������� (buf[j] != '\n') &&
> ����������� j < count; j++) {
> 
> Maybe
> 
> ������� for (j = i; (j < count) && 
> ����������� (buf[j] != ':') &&
> ����������� (buf[j] != '\0') &&
> ����������� (buf[j] != '\n'); j++) {
> 
> 2.
> 
> [linux-4.2-rc7/drivers/s390/block/dcssblk.c:726]: (style) Array index 'i' is used before limits check.
> 
> ��� for (i = 0; ((*(buf+i)!='\0') && (*(buf+i)!='\n') && i < count); i++) {
> 
> 3.
> 
> [linux-4.2-rc7/drivers/s390/block/dcssblk.c:909]: (style) Array index 'j' is used before limits check.
> 
> ������� for (j = i; (dcssblk_segments[j] != ',')� &&
> ��������������� (dcssblk_segments[j] != '\0') &&
> ��������������� (dcssblk_segments[j] != '(')� &&
> ��������������� (j < DCSSBLK_PARM_LEN); j++)

Thanks for the heads-up. This is broken(ish). I'll fix it.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
