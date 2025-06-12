package org.example.repository;

import org.apache.ibatis.annotations.Mapper;
import org.example.vo.Reply;

import java.util.List;

@Mapper
public interface ReplyRepository {
    public List<Reply> getForPrintReplies(int loginedMemberId, String relTypeCode, int relId);

    public void writeReply(int loginedMemberId, String body, String relTypeCode, int relId);

    public int getLastInsertId();

    public Reply getReply(int id);

    public void modifyReply(int id, String body);
}
